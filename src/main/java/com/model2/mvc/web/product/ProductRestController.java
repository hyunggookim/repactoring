package com.model2.mvc.web.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	
	@RequestMapping(value="json/search", method=RequestMethod.POST)
	public List<Map<String, Object>> searchProducts(@ModelAttribute Search search, @RequestParam int searchCondition, @RequestParam String searchKeyword) throws Exception {
	    System.out.println("/product/json/search : POST");
	    
	    search.setSearchCondition(String.valueOf(searchCondition));
	    search.setSearchKeyword(searchKeyword);
	    search.setPageSize(8);
	    search.setCurrentPage(1);
	    Map<String, Object> map = productService.getProductList(search);
	    System.out.println("map"+map);
	    List<Product> productList = (List<Product>) map.get("list");
	    
	    System.out.println("prodLIst"+productList);

	 // 중복 체크를 위한 Set
	    Set<Object> uniqueValues = new HashSet<>();

	    List<Map<String, Object>> response = new ArrayList<>();

	    for (Product product : productList) {
	        Map<String, Object> item = new HashMap<>();
	        Object valueToCheck = null;

	        switch (searchCondition) {
	            case 0:
	                valueToCheck = product.getProdNo();
	                item.put("label", valueToCheck);
	                item.put("value", valueToCheck);
	                break;
	            case 1:
	                valueToCheck = product.getProdName();
	                item.put("label", valueToCheck);
	                item.put("value", valueToCheck);
	                break;
	            case 2:
	                valueToCheck = product.getPrice();
	                item.put("label", valueToCheck);
	                item.put("value", valueToCheck);
	                break;
	        }

	        // 값이 uniqueValues 집합에 없는 경우에만 추가합니다.
	        if (!uniqueValues.contains(valueToCheck)) {
	            uniqueValues.add(valueToCheck);
	            System.out.println("restprodNO::" + product.getProdNo());
	            response.add(item);
	        }
	    }

	    return response;

	}



}