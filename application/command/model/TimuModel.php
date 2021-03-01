<?php
// +----------------------------------------------------------------------
// | snake
// +----------------------------------------------------------------------
// | Copyright (c) 2016~2022 http://baiyf.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: NickBai <1902822973@qq.com>
// +----------------------------------------------------------------------
namespace app\command\model;

use think\Model;

class TimuModel extends Model
{
    // 确定链接表名
    protected $name = 'user';

    /**
     * 插入数据
     */
    public function AddTimu()
    {
        return $this->alias('user')->field( 'user.*,role_name')
            ->join('role rol', 'user.role_id = ' . 'rol.id')
            ->where($where)->limit($offset, $limit)->order('id desc')->select();
    }
}
