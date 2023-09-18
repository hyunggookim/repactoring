package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseDao;

@Repository("PurchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDao {
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	///Constructor
	public PurchaseDaoImpl() {
		System.out.println(this.getClass());
	}

	///Method
	@Override
	public void insertPurchase(Purchase vo) throws Exception {
		sqlSession.insert("PurchaseMapper.insertPurchase", vo);
	}

	@Override
	public List<Purchase> getPurchaseList(Search search, String userId) throws Exception {
	    Map<String, Object> params = new HashMap<>();
	    
	    params.put("endRowNum", search.getEndRowNum());
	    params.put("startRowNum", search.getStartRowNum());
	    params.put("userId", userId);
	    params.put("searchCondition", search.getSearchCondition());
	    params.put("searchKeyword", search.getSearchKeyword());

	    return sqlSession.selectList("PurchaseMapper.getPurchaseList", params);
	}
	
	@Override
	public List<Purchase> getSaleList(Search search) throws Exception {
	    return sqlSession.selectList("PurchaseMapper.getSaleList", search);
	}

	@Override
	public Purchase findPurchase(int tranNo) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.findPurchase", tranNo);
	}

	@Override
	public void updateTranCode(Purchase purchase) throws Exception {
		sqlSession.update("PurchaseMapper.updateTranCode", purchase);
	}

	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		sqlSession.update("PurchaseMapper.updatePurchase", purchase);
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getTotalCount", search);
	}

}
