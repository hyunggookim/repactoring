package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService{
	
	
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;
	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}
	
	public ProductServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void insertProduct(Product product) throws Exception {
		productDao.insertProduct(product);
		
	}

	@Override
    public Map<String, Object> getProductList(Search search) throws Exception {
		List<Object> list= productDao.getProductList(search);
		System.out.println("list:: "+list);
		int totalCount = productDao.getTotalCount(search);
		System.out.println("totalcount:: "+totalCount);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
    }

	@Override
	public Product findProduct(int prodNo) throws Exception {
		System.out.println("prodNo serviceimpl: "+prodNo);
		return productDao.findProduct(prodNo);
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		productDao.updateProduct(product);
		
	}

	@Override
	public void decrementCount(int prodNo) {
		productDao.decrementCount(prodNo);
		
	}

}
