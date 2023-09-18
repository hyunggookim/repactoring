package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;

@Repository("productDaoImpl")
public class ProductDaoImpl implements ProductDao{
	
	///Field
		@Autowired
		@Qualifier("sqlSessionTemplate")
		private SqlSession sqlSession;
		public void setSqlSession(SqlSession sqlSession) {
			this.sqlSession = sqlSession;
		}

	public ProductDaoImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void insertProduct(Product product) throws Exception {
		sqlSession.insert("ProductMapper.insertProduct", product);
		
	}

	@Override
    public List<Object> getProductList(Search search) throws Exception {
		System.out.println("search form daoimpl::"+search);
		return sqlSession.selectList("ProductMapper.getProductList", search);
		
    }

	@Override
	public Product findProduct(int prodNo) throws Exception {
		return sqlSession.selectOne("ProductMapper.findProduct", prodNo);
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		sqlSession.update("ProductMapper.updateProduct", product);
		
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("ProductMapper.getTotalCount", search);
	}

	@Override
	public void decrementCount(int prodNo) {
		sqlSession.update("ProductMapper.decrementCount", prodNo);
		
	}

}
