<?php
namespace app\index\controller;

use think\Controller;

class Help extends Controller
{





	public function index(){
		return $this->fetch();
	}







	/**
	 * 订单中心-退款/退货
	 * @return [type] [description]
	 */
	public function mail_query(){
		return $this->fetch();
	}
	/**
	 * 订单中心-售后服务
	 * @return [type] [description]
	 */



	public function article1(){
		return $this->fetch();
	}


	public function article2(){
		return $this->fetch();
	}
	public function article3(){
		return $this->fetch();
	}
	public function article5(){
		return $this->fetch();
	}
	public function article6(){
		return $this->fetch();
	}
	public function article7(){
		return $this->fetch();
	}
	public function article8(){
		return $this->fetch();
	}
	public function article10(){
		return $this->fetch();
	}
	public function article11(){
		return $this->fetch();
	}
	public function article12(){
		return $this->fetch();
	}
}