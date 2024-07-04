<?php
namespace Drupal\helloworld\Controller;

use Drupal\Core\Controller\ControllerBase;
use Drupal\Core\Database\Connection;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Stichoza\GoogleTranslate\GoogleTranslate;
use Symfony\Component\HttpFoundation\Request;
class HelloWorldController extends ControllerBase {

  protected $database;

  public function __construct(Connection $database) {
    $this->database = $database;
  }

  public static function create(ContainerInterface $container) {
    return new static(
      $container->get('database'),
    );
  }

  protected $table = "about_us";

  private function getList($array = array(), $sortNew = 0) {
    $sql = 'SELECT * FROM ' . $this->table;
    if(isset($array['id'])){
      $sql .= ' WHERE ' . $this->table .'.id = '. $array['id'];
    }else if(isset($array['type'])){
      $sql .= ' WHERE ' . $this->table .'.type = '. $array['type'];
      if(isset($array['title'])){
        $sql .= ' AND '. $this->table .".title = '".$array['title']."'";
      } 
    }
    if(isset($array['id_parent'])){
      $sql .= ' WHERE ' . $this->table .'.id_parent = '. $array['id_parent'];
    }
    if($sortNew == 1){
      $sql .= ' ORDER BY created_at desc';
    }else{
      $sql .= ' ORDER BY sorts asc';
    }
    $query = $this->database->query($sql);
    $results = $query->fetchAll();
    return json_decode(json_encode($results),true);
  }

  private function InsertMultiple($array = array(),$id_parent = null) {
    $sql = 'INSERT INTO '.$this->table.'(title, description, images, id_parent) VALUES';
      foreach ($array as $key => $value) {
        if(!isset($value['id'])){
          $value['id_parent'] = $id_parent;
          if(count($array) == ($key + 1)) {
            $sql .= "('".$value['title']."','".$value['description']."','".$value['images']."','".$value['id_parent']."')";
          }else{
            $sql .= "('".$value['title']."','".$value['description']."','".$value['images']."','".$value['id_parent']."'),";
          }
        }
      }
      
    $query = $this->database->query($sql); 
    $results = $query->execute();
    return $results;
  }
  private function createAboutUs($array = array()) {
    if(isset($array["children"])){
      unset($array["children"]);
    }
    $query = $this->database->insert($this->table)->fields($array)->execute();
    return $query;
  }
  private function deleteAboutUs($id = '') {
    $query = $this->database->delete($this->table)
    ->condition('id', $id)
    ->execute();
    return $query;
  }
  private function update($id, $array = array()) {
    if(isset($array["children"])){
      unset($array["children"]);
    }
  
    $query = $this->database->update($this->table)->fields($array)->condition('id', $id)->execute();
    return $query;
  }
  private function translations($values = array(), $lang = 'zh-Hans') {
    // Dịch dữ liệu
    $translated_results = [];
    $translator = new GoogleTranslate($lang);
    foreach ($values as $key => $result) {
      $translated_results[$key]['title'] = $result['title'] ? $translator->translate($result['title']) : '';
      $translated_results[$key]['description'] = $result['description'] ? $translator->translate($result['description']) : '';
    }
    return $translated_results;
  }
  /**
		 * Convert Data Array ByKey
		 *
		 * @param $arr
		 * @param $keyColumn
		 * @return array
		 */
		protected function convertDataArrayByKey ($arr, $keyColumn, $isCheck = true)
		{
			$data = [];
			foreach ($arr as $key => $item) {
				if ($isCheck) {
					$data[$item[$keyColumn]][] = $item;
				} else {
					$data[$item[$keyColumn]] = $item;
				}
			}
			return $data;
		}
  private function convertData($data = array(), $checkQuery) {
    $listData = array();
    $listDataChildren = array();   
    if(count($data) <= 1 && !empty($checkQuery)){
      $listDataChildren = $this->getList(["id_parent"=>$data[0]['id']]);
      $listData = $data[0];
      $listData['children'] = $listDataChildren;
      return $listData;
    }else{
      foreach ($data as $key => $value) {
        if(empty($value['id_parent'])){
          $listData[$key] = $value;
        }else{
          $listDataChildren[$key] = $value;
        }
      }
      $listData = $this->convertDataArrayByKey($listData,'id',false);
      foreach ($listDataChildren as $key => $value) {
        $listData[$value['id_parent']]['children'][] = $value;
      }
      return array_values($listData);
    }
  
     
  }
  public function abouUsApi(Request $request) {
    try {
      $method = \Drupal::request()->getMethod();
      $results = ['error'=>false,'results'=> [],'message' => 'Get data successfull'];
      $query = \Drupal::request()->query->all();
      //code...

      if($method == 'GET'){
        $results['results'] = empty($query) ? $this->getList() : $this->getList($query);
        
        if(isset($query['lang'])){
          $results['results'] = $this->translations($results['results'],$query['lang']);
        }
        $results['results'] = $this->convertData($results['results'], $query);
        
      }else if($method == 'POST'){
        $body = json_decode($request->getContent(), true);
        $listType = [2,4,5];
        $child = $body["children"];

        if(isset($query['id'])){
          // update
          $this->update($query['id'], $body);
          if(count($child) > 0){
            if(count($child) > count(array_column($child, 'id'))){
              $this->InsertMultiple($child, $query['id']);
            }

            foreach ($child as $key => $value) {
              unset($value["index"]);
              if(isset($value['id'])){
                $this->update($value['id'], $value);
              }
            }
          }

          $results['message'] = "Update successfull";
        }else{
          // Create 
          $this->createAboutUs($body);
          if(in_array($body['type'], $listType)){
            $dataNew = $this->getList(['type' => $body['type'], 'title' => $body['title']],1)[0];

            if(count($child) > 0){
              $this->InsertMultiple($child,$dataNew['id']);
            }
          }
          $results['message'] = "Create successfull";
        }
      }
      
    return new JsonResponse($results);
    } catch (\Throwable $th) {
      throw $th;
    }
  }

  public function deteteItemApi() {
    try {
      $results = ['error'=>false,'results'=> [],'message' => 'Delete data successfull'];
      $query = \Drupal::request()->query->all();
      if(isset($query['id'])){
        $this->deleteAboutUs($query['id']);
      }else{
        $results['message'] = 'Id is invalid';
      }
      return new JsonResponse($results);
    } catch (\Throwable $th) {
      throw $th;
    }
  }
  public function SortItemApi() {
    try {
      $results = ['error'=>false,'results'=> [],'message' => 'Change position data successfull'];
      $query = \Drupal::request()->query->all();

      if(!empty($query['id']) && !empty($query['sort'])){
        $this->update($query['id'], array('sorts'=> $query['sort']));
      }else{
        $results['message'] = 'Id is invalid';
      }
     
      return new JsonResponse($results);
    } catch (\Throwable $th) {
      throw $th;
    }
  }

}
