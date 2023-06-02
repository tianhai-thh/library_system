package com.library.service;

import com.library.bean.Admin;
import com.library.bean.ReaderCard;
import com.library.dao.AdminDao;
import com.library.dao.ReaderCardDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class LoginService {

    @Autowired
    private ReaderCardDao readerCardDao;
    @Autowired
    private AdminDao adminDao;

    public boolean hasMatchReader(String email,String password){
        return  readerCardDao.getIdMatchCount(email, password)>0;
    }

    public String getAdminUsername(long adminId) {
        return adminDao.getUsername(adminId);
    }

    public ReaderCard findReaderCardByReaderId(long readerId){
        return readerCardDao.findReaderByReaderId(readerId);
    }

    public boolean hasMatchAdmin(String email,String password){
        return adminDao.getMatchCount(email, password) == 1;
    }

    public boolean adminRePassword(long adminId, String newPassword){
        return adminDao.resetPassword(adminId,newPassword)>0;
    }
    public Admin getAdmin(String email)
    {
        Map<String, Object> map = new HashMap<>();
        map.put("email", email);
        return adminDao.getAdmin(email);
    }

    public ReaderCard getReaderCard(String email)
    {
        Map<String, Object>map = new HashMap<>();
        map.put("email", email);
        return readerCardDao.getReaderCard(email);
    }
    public String getAdminPassword(long adminId){
        return adminDao.getPassword(adminId);
    }

    public boolean readerRePassword(long readerId, String newPassword) {
        return readerCardDao.resetPassword(readerId, newPassword) > 0;
    }

    public String getReaderPassword(long readerId) {
        return readerCardDao.getPassword(readerId);
    }


}
