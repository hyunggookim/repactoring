package com.model2.mvc.service.purchase;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao {
	public void insertPurchase(Purchase vo) throws Exception;

	public List<Purchase> getPurchaseList(Search search, String userId) throws Exception;

	Purchase findPurchase(int tranNo) throws Exception;

	public void updateTranCode(Purchase purchase) throws Exception;

	public void updatePurchase(Purchase purchase) throws Exception;

	public int getTotalCount(Search search) throws Exception;

	public List<Purchase> getSaleList(Search search) throws Exception;


}
