<?php
namespace app\index\controller;

use think\Controller;

class Order extends Controller
{

	/**
	 * 订单中心-我的订单
	 * @return [type] [description]
	 */
	public function order(){
		return $this->fetch();
	}
	/**
	 * 订单中心-我的收藏
	 * @return [type] [description]
	 */
	public function collection(){
		return $this->fetch();
	}
	/**
	 * 订单中心-退款/退货
	 * @return [type] [description]
	 */
	public function refund(){
		return $this->fetch();
	}

	public function order_detail(){
		return $this->fetch();
	}

	public function order_receipted(){
		return $this->fetch();
	}

	public function order_evaluate(){
		return $this->fetch();
	}
}
