<?php
namespace app\index\controller;

use think\Controller;

class Shoudong extends Controller
{
    public function zhishidian()
    {
        return $this->fetch();
    }
    public function zhangjie(){
		return $this->fetch();
	}
	public function item_show(){
		return $this->fetch();
	}
}
