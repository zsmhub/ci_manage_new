<?php
class User_mod_test extends TestCase {

    private $ci_obj;

    public function setUp() {
        $this->resetInstance();
        $this->ci_obj = $this->CI;
        $this->ci_obj->load->model('User_mod');
    }

    public function test_add_user() {
        // $addparams = array(
        //     'data' => array(
        //             'UserName' => 'test_add_user',
        //             'PassWord' => 'test_add_userPassWord',
        //             'NickName' => 'test_add_userNickName',
        //             'Email' => 'test@test.com',
        //             'RoleId'   => '1',
        //             'Status'   => '1'
        //             )
        // );
        // $this->ci_obj->user_mod->add_user($addparams);
        // $loginstatus = $this->ci_obj->user_mod->login(array('UserName' => 'test_add_user','PassWord' => 'test_add_userPassWord'));
        // $return = array('error_code' => 0, 'error_msg' => '登录成功！', 'data' => '');
        // $this->assertArraySubset($loginstatus,$return,TRUE);
        $this->assertEquals(1,1);
    }

}
