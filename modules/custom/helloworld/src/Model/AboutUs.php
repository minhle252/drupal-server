<?php

namespace Drupal\helloworld\Model;

use Drupal\Core\Database\Database;

class AboutUs
{
    protected $table = "about_us";
    
    public function getList()
    {
        $connection = Database::getConnection();
        $data = array();
        $query = $connection->select($this->table, 't')->fields('t', ['title', 'description', 'background']); 
        $results = $query->execute()->fetchAll();
        return $results;
    }
}