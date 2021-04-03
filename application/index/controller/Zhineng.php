<?php
namespace app\index\controller;

use think\Controller;

class Zhineng extends Controller
{
    public function zhishidian()
    {
        return $this->fetch();
    }
    public function zhangjie(){
		return $this->fetch();
	}
}
