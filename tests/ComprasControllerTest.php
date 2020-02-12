<?php

# app/tests/controllers/PostsControllerTest.php

class ComprasControllerTest extends TestCase {

    public function testIndex()
    {
        $this->call('GET', 'comprasarticulos');
    }

}
