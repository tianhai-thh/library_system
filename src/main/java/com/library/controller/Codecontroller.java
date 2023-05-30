package com.library.controller;

import com.library.Util.CheckCodeUtil;
import com.library.bean.Admin;
import com.library.bean.ReaderCard;
import com.library.bean.ReaderInfo;
import com.library.service.ReaderCardService;
import com.library.service.ReaderInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@ResponseBody
public class Codecontroller extends HttpServlet {
    @Autowired
    ReaderCardService service;
    @Autowired
    ReaderInfoService readerInfoService;
    @RequestMapping(value = "/Codecontroller")
    protected void Codecontroller(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //生成验证码
        ServletOutputStream os = response.getOutputStream();
        String checkCode = CheckCodeUtil.outputVerifyImage(100, 50, os, 4);

        //存入session
        HttpSession session = request.getSession();
        session.setAttribute("checkCodeGen",checkCode);
    }

    @RequestMapping(value = "/registerCodecontroller")
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //1.获取邮箱和密码
        String name = request.getParameter("name");
        String password = request.getParameter("password");

        //获取用户输入的验证码
        String checkCode = request.getParameter("checkCode");

        //获取程序生成的验证码，从session获取
        HttpSession session = request.getSession();
        String checkCodeGen = (String) session.getAttribute("checkCodeGen");


        //比对
        if(!checkCodeGen.equalsIgnoreCase(checkCode)){
            request.setAttribute("register_msg","验证码错误");
            request.getRequestDispatcher("/toregister").forward(request,response);
            return;
        }


        //2.封装为user对象
        ReaderCard user = new ReaderCard();
        user.setName(name);
        user.setPassword(password);

        System.out.println(user);

//        String email = request.getParameter("email");
        String sex = request.getParameter("sex");
        String birth = request.getParameter("birth");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        Date date = new Date();
        try {
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            date = df.parse(birth);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        ReaderInfo readerInfo = new ReaderInfo();
        readerInfo.setAddress(address);
        readerInfo.setName(name);
        readerInfo.setSex(sex);
        readerInfo.setPhone(phone);
        readerInfo.setBirth(date);
        //3.调用service注册
//        boolean flag = (service.register(user) > 0) && (readerInfoService.addReaderInfo(readerInfo) > 0);

        long readerId = readerInfoService.addReaderInfo(readerInfo);
        readerInfo.setReaderId(readerId);

        //4.判断注册成功与否
        if(readerId > 0 && service.addReaderCard(readerInfo, password)){
            request.setAttribute("register_msg","注册成功，请登录");
            request.getRequestDispatcher("").forward(request,response);
        }else {
            request.setAttribute("register_msg","注册失败");
            request.getRequestDispatcher("/toregister").forward(request,response);
        }

    }
}
