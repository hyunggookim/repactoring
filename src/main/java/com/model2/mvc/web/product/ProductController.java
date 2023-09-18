package com.model2.mvc.web.product;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {
		///Field
		@Autowired
		@Qualifier("productServiceImpl")
		private ProductService productService;
		//setter Method 구현 않음
			
		public ProductController(){
			System.out.println(this.getClass());
		}
		
		//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
		//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
		@Value("#{commonProperties['pageUnit']}")
		//@Value("#{commonProperties['pageUnit'] ?: 3}")
		int pageUnit;
		
		@Value("#{commonProperties['pageSize']}")
		//@Value("#{commonProperties['pageSize'] ?: 2}")
		int pageSize;
		
		//@RequestMapping("/addProduct.do")
		@RequestMapping( value="addProduct", method=RequestMethod.POST )
		public String addProduct(@ModelAttribute("product") Product product, HttpSession session, HttpServletRequest request) throws Exception {

			System.out.println("/product/addProduct : POST");
			
			ServletContext context = request.getServletContext();
		    String temDir = context.getRealPath("/images/uploadFiles/") + File.separator;

			System.out.println(temDir);
			int size = 100 * 1024 * 1024;
			
			MultipartFile multipartFile = product.getImageFile();
			System.out.println("price:: "+product.getPrice());
			System.out.println("manudat:: "+product.getManuDate());
		    // 파일 저장 코드
		    if(multipartFile != null && !multipartFile.isEmpty()) {
		        String originalFilename = multipartFile.getOriginalFilename();
		        String filePath = temDir + originalFilename; 
		        multipartFile.transferTo(new File(filePath));
		        
		        product.setFileName(originalFilename); // 파일 이름을 도메인에 설정
		    }
		    System.out.println(multipartFile.getOriginalFilename());

		    product.setManuDate(product.getManuDate().replace("-",""));
		    
		    // Business Logic
		    productService.insertProduct(product);
		    
		    // Add the product to the session
		    session.setAttribute("nonovo", product);
		    
		    return "forward:/product/getNoNoProduct.jsp";
		}

	
		//@RequestMapping("/getProduct.do")
		@RequestMapping( value="getProduct", method=RequestMethod.GET )
		public String findProduct( @RequestParam("prodNo") int prodNo , Model model ) throws Exception {
			
			System.out.println("/getProduct.do");
			//Business Logic
			Product product = productService.findProduct(prodNo);
			// Model 과 View 연결
			model.addAttribute("vo", product);
			
			return "forward:/product/getProduct.jsp";
		}
		
		//@RequestMapping("/updateProductView.do")
		//public String updateProductView( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{
		@RequestMapping( value="updateProduct", method=RequestMethod.GET )
		public String updateProduct( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{
			System.out.println("/product/updateProduct : GET");

			//Business Logic
			Product product = productService.findProduct(prodNo);
			// Model 과 View 연결
			model.addAttribute("vo", product);
			
			return "forward:/product/UpdateProduct.jsp";
		}
		
		//@RequestMapping("/updateProduct.do")
		@RequestMapping( value="updateProduct", method=RequestMethod.POST )
	    public String updateProduct(@ModelAttribute Product product, Model model, HttpSession session, HttpServletRequest request) throws Exception {
	        System.out.println("/updateProduct.do");
	        
	        ServletContext context = request.getServletContext();
		    String temDir = context.getRealPath("/images/uploadFiles/") + File.separator;

			System.out.println(temDir);
			int size = 100 * 1024 * 1024;
			
			MultipartFile multipartFile = product.getImageFile();
			System.out.println("price:: "+product.getPrice());
			System.out.println("manudat:: "+product.getManuDate());
		    // 파일 저장 코드
		    if(multipartFile != null && !multipartFile.isEmpty()) {
		        String originalFilename = multipartFile.getOriginalFilename();
		        String filePath = temDir + originalFilename; 
		        multipartFile.transferTo(new File(filePath));
		        
		        product.setFileName(originalFilename); // 파일 이름을 도메인에 설정
		    }

	        // Business Logic
	        productService.updateProduct(product);
	        System.out.println("prodNo:: "+product.getProdNo());
	        return "redirect:/product/getProduct?prodNo=" + product.getProdNo();
	    }
		
		@RequestMapping(value="listProduct")
		public String listProduct(@ModelAttribute Search search, Model model, HttpServletRequest request) throws Exception {
		    
		    System.out.println("/product/listProduct : GET / POST");
		    
		    if(search.getCurrentPage() == 0){
		        search.setCurrentPage(1);
		    }
		    search.setPageSize(pageSize);
		    
		    // Business logic 수행
		    Map<String, Object> map = productService.getProductList(search);
		    System.out.println("search::" + search);
		    System.out.println("MAP:: " + map);
		    Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		    System.out.println(resultPage);
		    
		    // Model 과 View 연결
		    model.addAttribute("list", map.get("list"));
		    model.addAttribute("resultPage", resultPage);
		    model.addAttribute("search", search);
		    
		    return "forward:/product/getProductList.jsp";
		}

}
