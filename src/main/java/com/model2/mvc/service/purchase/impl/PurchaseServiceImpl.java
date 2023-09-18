package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.PurchaseDao;

@Service("PurchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService {

	///Field
	@Autowired
	@Qualifier("PurchaseDaoImpl")
	private PurchaseDao purchaseDao;
	public void setPurchaseDao(PurchaseDao purchaseDao) {
		this.purchaseDao = purchaseDao;
	}
	
	///Constructor
	public PurchaseServiceImpl() {
		System.out.println(this.getClass());
	}
	
	///Method
	@Override
	public void insertPurchase(Purchase purchase) throws Exception {
		purchaseDao.insertPurchase(purchase);
	}

	@Override
	public Purchase findPurchase(int tranNo) throws Exception {
		return purchaseDao.findPurchase(tranNo);
	}

	@Override
	public Map<String, Object> getPurchaseList(Search search, String userId) throws Exception {
	    List<Purchase> list = purchaseDao.getPurchaseList(search, userId);
	    int totalCount = purchaseDao.getTotalCount(search);
	    
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("list", list);
	    map.put("totalCount", new Integer(totalCount));
	    
	    return map;
	}
	
	@Override
	public Map<String, Object> getSaleList(Search search) throws Exception {
	    List<Purchase> list = purchaseDao.getSaleList(search);
	    int totalCount = purchaseDao.getTotalCount(search);
	    
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("list", list);
	    map.put("totalCount", new Integer(totalCount));
	    
	    return map;
	}


	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		purchaseDao.updatePurchase(purchase);
	}

	@Override
	public void updateTranCode(Purchase purchase) throws Exception {
		purchaseDao.updateTranCode(purchase);
	}


	// Add any additional methods from the PurchaseService interface as needed

}
