package com.controller;

import com.alibaba.fastjson.JSON;
import com.domain.PageInfo;
import com.domain.User;
import com.service.UserService;
import com.util.MySpring;
import jdk.internal.util.xml.impl.Input;
import mymvc.ModelAndView;
import mymvc.RequestMapping;
import mymvc.RequestParam;
import mymvc.ResponseBody;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserController {

    private UserService userService = MySpring.getBean("com.service.impl.UserServiceImpl");

    private static HttpSession session = null;

    @RequestMapping("login.do")
    public String login(@RequestParam("uname") String uname, @RequestParam("upass") String upass, HttpServletRequest request){
        User user = userService.login(uname,upass);
        if(user!=null){//证明登录成功
            session = request.getSession();
            session.setAttribute("user",user);
            return "main.jsp";
        }
        return "redirect:index.jsp?login=0";
    }

    @RequestMapping("userList.do")
    public ModelAndView userList(@RequestParam("uno") Integer uno,@RequestParam("uname")String uname,@RequestParam("sex")String sex,@RequestParam("page")Integer page,@RequestParam("row")Integer row){
        if(page==null){
            page = 1;
            row = 5;
        }
        Map<String,Object> params = new HashMap<>();
        params.put("uno",uno);
        params.put("uname",uname);
        params.put("sex",sex);
        params.put("page",page);
        params.put("row",row);
        User user = (User)session.getAttribute("user");
        params.put("userUno",user.getUno());
        PageInfo info = userService.findUserByCondition(params);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("userList.jsp");
        mv.addAttribute("info",info);
        mv.addAttribute("uno",uno);
        mv.addAttribute("uname",uname);
        mv.addAttribute("sex",sex);
        mv.addAttribute("page",page);
        mv.addAttribute("row",row);
        return mv ;
    }

    @RequestMapping("addUser.do")
    public String addUser(@RequestParam("uname")String uname,@RequestParam("truename") String truename,@RequestParam("age") Integer age,@RequestParam("sex") String sex,@RequestParam("yl1") String yl1,@RequestParam("yl2") String yl2){
        Map<String,Object> params = new HashMap<>();
        params.put("uname",uname);
        params.put("truename",truename);
        params.put("age",age);
        params.put("sex",sex);
        params.put("yl1",yl1);
        params.put("yl2",yl2);
        String result = userService.addUser(params);
        return "addUserResult.jsp?result="+result;
    }

    @RequestMapping("deleteUser.do")
    public String deleteUser(@RequestParam("uno") Integer uno){
        Map<String,Object> params = new HashMap<>();
        params.put("uno",uno);
        params.put("del",2);
        userService.deleteUser(params);
        return "redirect:userList.do";
    }

    @RequestMapping("editUser.do")
    public String editUser(User user){
        userService.editUser(user);

        return "redirect:userList.do";
    }

    @RequestMapping("updateUser.do")
    public String updateUser(User user){
        userService.editUser(user);
        User newUser = userService.findUserById(user.getUno());
        session.setAttribute("user",newUser);
        return "redirect:main.jsp";
    }

    @RequestMapping("deleteList.do")
    public String deleteList(@RequestParam("checkBox")String unos){
        String[] uno = unos.split(",");
        for(String u:uno){
            Map<String,Object> params = new HashMap<>();
            params.put("uno",Integer.parseInt(u));
            params.put("del",2);
            userService.deleteUser(params);
        }
        return "redirect:userList.do";
    }

    @RequestMapping("importUsers.do")
    public String importUsers(HttpServletRequest request)throws FileUploadException, IOException {
        //文件上传处理
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload fileUpload = new ServletFileUpload(factory);
        List<FileItem> files = fileUpload.parseRequest(request);
        FileItem file = files.get(0);
        //获取到文件读取的流
        InputStream is = file.getInputStream();

        //使用POI将上传的excel格式还原
        List<User> users = new ArrayList<User>();
        Workbook workbook = WorkbookFactory.create(is);
        Sheet sheet = workbook.getSheetAt(0);
        for (int i=1;i<=sheet.getLastRowNum();i++){
            Row row = sheet.getRow(i);
            Cell c1 = row.getCell(0);
            Cell c2 = row.getCell(1);
            Cell c3 = row.getCell(2);
            Cell c4 = row.getCell(3);
            Cell c5 = row.getCell(4);

            String uname = c1.getStringCellValue();
            String upass = (int)c2.getNumericCellValue()+"";
            String truename = c3.getStringCellValue();
            String sex = c4.getStringCellValue();
            Integer age = (int)c5.getNumericCellValue();

            User user = new User(null,uname,upass,truename,age,sex,null,null);
            users.add(user);
        }
        int result = userService.importUsers(users);
        return "redirect:userList.do";
    }

    @RequestMapping("downloadTemplate.do")
    public void downloadTemplate(HttpServletResponse response) throws IOException{
        //与files文件夹中的下载文件建立流管道
        String path = Thread.currentThread().getContextClassLoader().getResource("files/Users.xlsx").getPath();
        InputStream fis = new FileInputStream(path);
        //获取输出流
        OutputStream os = response.getOutputStream();
        //设置头信息
        response.setHeader("content-disposition","attachment;filename=users.xlsx");
        while(true){
            int data = fis.read();
            if(data==-1){
                break;
            }
            os.write(data);
        }
    }

    @RequestMapping("exportUsers.do")
    public void exportUsers(@RequestParam("unos")String unos,HttpServletResponse response) throws IOException {
        String[] exportUno = unos.split(",");
        //拿一个list集合装入需要导出的User对象
        List<User> users = new ArrayList<>();
        for(String u:exportUno) {
            Integer uno = new Integer(u);
            User user = userService.exportUser(uno);
            users.add(user);
        }
        //创建虚拟机的
        Workbook book = new XSSFWorkbook();
        Sheet sheet = book.createSheet();
        {
            Row row = sheet.createRow(0);
            Cell c1 = row.createCell(0);
            Cell c2 = row.createCell(1);
            Cell c3 = row.createCell(2);
            Cell c4 = row.createCell(3);
            Cell c5 = row.createCell(4);
            c1.setCellValue("用户编号");
            c2.setCellValue("用户名");
            c3.setCellValue("真实姓名");
            c4.setCellValue("年龄");
            c5.setCellValue("性别");
        }
        for(int i=1;i<=users.size();i++){
            Row row = sheet.createRow(i);
            Cell c1 = row.createCell(0);
            Cell c2 = row.createCell(1);
            Cell c3 = row.createCell(2);
            Cell c4 = row.createCell(3);
            Cell c5 = row.createCell(4);
            c1.setCellValue(users.get(i-1).getUno());
            c2.setCellValue(users.get(i-1).getUname());
            c3.setCellValue(users.get(i-1).getTruename());
            c4.setCellValue(users.get(i-1).getAge());
            c5.setCellValue(users.get(i-1).getSex());
        }
        File file = new File("D://临时//users.xslx");
        OutputStream os = new FileOutputStream(file);
        book.write(os);

        InputStream is = new FileInputStream("D://临时//users.xslx");
        OutputStream fos = response.getOutputStream();

        response.setHeader("content-disposition","attachment;filename=users.xlsx");
        while(true){
            int data = is.read();
            if(data==-1){
                break;
            }
            fos.write(data);
        }
        fos.close();
    }

    @RequestMapping("logout.do")
    public String logout(){
        try {
            session.invalidate();
        }catch (Exception e){
            
        }
        return "redirect:index.jsp";
    }

    @RequestMapping("updatePwd.do")
    @ResponseBody
    public String UpdatePwd(@RequestParam("oldPass")String oldPass,@RequestParam("newPass")String newPass){
        User user = (User) session.getAttribute("user");
        return userService.updatePwd(user.getUno(),oldPass,newPass);
    }
}
