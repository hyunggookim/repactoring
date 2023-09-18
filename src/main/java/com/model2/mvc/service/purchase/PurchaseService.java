package com.model2.mvc.service.purchase;

import java.util.HashMap;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseService {

	public void insertPurchase(Purchase vo) throws Exception;

	Purchase findPurchase(int tranNo) throws Exception;

	public void updateTranCode(Purchase purchaseVO) throws Exception;

	public void updatePurchase(Purchase purchaseVO) throws Exception;

	Map<String, Object> getPurchaseList(Search search, String userId) throws Exception;

	Map<String, Object> getSaleList(Search search) throws Exception;

}
