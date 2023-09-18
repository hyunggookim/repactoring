package com.model2.mvc.web.purchase;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {

	/// Field
	@Autowired
	@Qualifier("PurchaseServiceImpl")
	private PurchaseService purchaseService;
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	// setter Method 구현 않음

	public PurchaseController() {
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@RequestMapping(value = "addPurchase", method = RequestMethod.GET)
	public String addPurchase(@RequestParam("prodNo") int prodNo, Model model, HttpSession session) throws Exception {

		System.out.println("/purchase/addPurchase : GET");
		System.out.println("prodNo: " + prodNo);

		Product product = productService.findProduct(prodNo);

		session.setAttribute("pdvo", product);

		System.out.println("product pdvo: " + product);

		User user = (User) session.getAttribute("user");
		model.addAttribute("uvo", user);
		System.out.println("user uvo: " + user);

		return "forward:/purchase/addPurchaseView.jsp";
	}

	// @RequestMapping("/addUser.do")
	@RequestMapping(value = "addPurchase", method = RequestMethod.POST)
	public String addPurchase(@ModelAttribute("purchase") Purchase purchase, HttpSession session) throws Exception {

		User user = (User) session.getAttribute("user");
		Product product = (Product) session.getAttribute("pdvo");
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		
		System.out.println(purchase);
		System.out.println("/purchase/insertPurchase : POST");
		
		int prodNo = product.getProdNo();
		// Business Logic
		if(product.getCount() > 0) {
			productService.decrementCount(prodNo);
			purchase.setTranCode('1');
		}
		
		
		purchaseService.insertPurchase(purchase);
		
		return "forward:/purchase/addPurchaseComplete.jsp";
	}

	@RequestMapping(value = "listPurchase")
	public String listPurchase(@ModelAttribute Search search, Model model, HttpServletRequest request,
			HttpSession session) throws Exception {

		System.out.println("/purchase/listPurchase : GET / POST");
		User user = (User) session.getAttribute("user");
		String userId = user.getUserId();

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		// Business logic 수행
		Map<String, Object> map = purchaseService.getPurchaseList(search, userId);
		System.out.println("search::" + search);
		System.out.println("MAP:: " + map);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);

		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "forward:/purchase/getPurchaseList.jsp";
	}

	@RequestMapping(value = "listSale")
	public String listSale(@ModelAttribute Search search, Model model, HttpServletRequest request) throws Exception {

		System.out.println("/purchase/listSale : GET / POST");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		// Business logic 수행
		Map<String, Object> map = purchaseService.getSaleList(search);
		System.out.println("search::" + search);
		System.out.println("MAP:: " + map);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);
		List<Purchase> list = (List<Purchase>) map.get("list");

		for (Purchase purchase : list) {
			Product purchaseProduct = purchase.getPurchaseProd();
			int prodNo = purchaseProduct.getProdNo();
			Product productFromDB = productService.findProduct(prodNo);
			System.out.println("trancode::" + purchase.getTranCode());

			purchaseProduct.setFileName(productFromDB.getFileName());
			purchaseProduct.setManuDate(productFromDB.getManuDate());
			purchaseProduct.setProdDetail(productFromDB.getProdDetail());
			purchaseProduct.setProdName(productFromDB.getProdName());
			purchaseProduct.setPrice(productFromDB.getPrice());
			// 이제 prodNo 변수를 사용해서 원하는 작업을 수행할 수 있습니다.
			System.out.println(prodNo);
		}

		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "forward:/purchase/getSaleList.jsp";
	}

	@RequestMapping(value = "updateTranCodeByProd", method = RequestMethod.GET)
	public String updateTranCodeByProd(@ModelAttribute("purchase") Purchase purchase, @RequestParam("tranNo") int tranNo, @RequestParam("tranCode") char tranCode,@RequestParam("role") String role) throws Exception {

		
		purchase = purchaseService.findPurchase(tranNo);
		purchase.setTranCode(tranCode);
		// Business Logic
		purchaseService.updateTranCode(purchase);
		System.out.println(role);
		if(role.equals("user")) {
		    return "redirect:/purchase/listPurchase";
		} else {
		    return "redirect:/purchase/listSale";
		}

	}
	
	@RequestMapping( value="getPurchase", method=RequestMethod.GET )
	public String findProduct( @RequestParam("tranNo") int tranNo , Model model ) throws Exception {
		
		System.out.println("/getPurchase.do");
		//Business Logic
		Purchase purchase = purchaseService.findPurchase(tranNo);
		// Model 과 View 연결
		model.addAttribute("vo", purchase);
		
		return "forward:/purchase/getPurchaseview.jsp";
	}
	
	@RequestMapping( value="updatePurchase", method=RequestMethod.GET )
    public String updatePurchase(@RequestParam("tranNo") int tranNo , Model model, HttpSession session) throws Exception {
        System.out.println("/updatePurchase get");
        
        Purchase purchase = purchaseService.findPurchase(tranNo);
        // Business Logic

        
        model.addAttribute("vo", purchase);
        
        
        
        return "forward:/purchase/UpdatePurchaseView.jsp";
        
    }
	
			
			//@RequestMapping("/updateProduct.do")
			@RequestMapping( value="updatePurchase", method=RequestMethod.POST )
		    public String updatePurchase(@ModelAttribute Purchase purchase, Model model, HttpSession session) throws Exception {
		        System.out.println("/updateProduct post");

		        // Business Logic
		        purchaseService.updatePurchase(purchase);
		        model.addAttribute("vo", purchase);

		        return "forward:/purchase/getPurchaseview.jsp?tranNo=" + purchase.getTranNo();
		    }
}
