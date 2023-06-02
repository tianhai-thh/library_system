package com.library.service;

import com.library.bean.Admin;
import com.library.bean.ReaderCard;
import com.library.bean.ReaderInfo;
import com.library.dao.ReaderCardDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class ReaderCardService {
    @Autowired
    private ReaderCardDao readerCardDao;
    public boolean addReaderCard(ReaderInfo readerInfo, String email, String password){
        return  readerCardDao.addReaderCard(readerInfo,email, password)>0;
    }
    public boolean updatePassword(long readerId, String password){
        return readerCardDao.resetPassword(readerId,password)>0;
    }

    public boolean getReaderCard(String email)
    {
        ReaderCard readerCard = readerCardDao.getReaderCard(email);
        if(readerCard == null)return true;
        else return false;
    }

    public boolean deleteReaderCard(long readerId) {
        return readerCardDao.deleteReaderCard(readerId) > 0;
    }
}
