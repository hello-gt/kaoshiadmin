<?php
namespace app\index\controller;

use think\Controller;

class User extends Controller
{
	/**
	 * 账户信息-个人资料
	 * @return [type] [description]
	 */
	public function setting(){
		return $this->fetch();
	}
	/**
	 * 账户信息-资金管理
	 * @return [type] [description]
	 */
	public function treasurer(){
		return $this->fetch();
	}

	/**
	 * 账户信息-积分平台
	 * @return [type] [description]
	 */
	public function integral(){
		return $this->fetch();
	}

	/**
	 * 账户信息-收货地址
	 * @return [type] [description]
	 */
	public function address(){
		return $this->fetch();
	}
    /**
	 * 账户信息-积分平台
	 * @return [type] [description]
	 */
	public function coupon(){
		return $this->fetch();
	}
    /**
	 * 账户信息-修改支付密码
	 * @return [type] [description]
	 */

	public function paypwd_modify(){
		return $this->fetch();
	}
    /**
	 * 账户信息-修改登陆密码
	 * @return [type] [description]
	 */
	public function pwd_modify(){
		return $this->fetch();
	}

	public function modifypay_step1(){
		return $this->fetch();
	}
	public function modifypay_step2(){
		return $this->fetch();
	}	
	public function modifypay_step3(){
		return $this->fetch();
	}
	public function modifypwd_step1(){
		return $this->fetch();
	}
	public function modifypwd_step2(){
		return $this->fetch();
	}
	public function modifypwd_step3(){
		return $this->fetch();
	}
}
