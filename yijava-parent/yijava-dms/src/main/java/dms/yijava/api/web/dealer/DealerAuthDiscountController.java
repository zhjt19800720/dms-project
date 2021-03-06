package dms.yijava.api.web.dealer;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yijava.orm.core.JsonPage;
import com.yijava.orm.core.PageRequest;
import com.yijava.orm.core.PropertyFilter;
import com.yijava.orm.core.PropertyFilters;
import com.yijava.web.vo.Result;

import dms.yijava.entity.dealer.DealerAuthDiscount;
import dms.yijava.service.dealer.DealerAuthDiscountService;

@Controller
@RequestMapping("/api/dealerAuthDiscount")
public class DealerAuthDiscountController {
	

	@Autowired
	private DealerAuthDiscountService dealerAuthDiscountService;
	

	@ResponseBody
	@RequestMapping("paging")
	public JsonPage<DealerAuthDiscount> paging(PageRequest pageRequest,HttpServletRequest request) {
		List<PropertyFilter> filters = PropertyFilters.build(request);
		return dealerAuthDiscountService.paging(pageRequest,filters);
	}
	
	
	@ResponseBody
	@RequestMapping("save")
	public Result<String> save(@ModelAttribute("entity") DealerAuthDiscount entity) {
		try {
			dealerAuthDiscountService.saveEntity(entity);
			return new Result<String>(entity.getDealer_id(), 1);
		}catch (org.springframework.dao.DuplicateKeyException e){
			return new Result<String>(entity.getDealer_id(), 2);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return new Result<String>(entity.getDealer_id(), 0);
	}
	
	
	@ResponseBody
	@RequestMapping("update")
	public Result<String> update(@ModelAttribute("entity") DealerAuthDiscount entity) {
		try {
			dealerAuthDiscountService.updateEntity(entity);
			return new Result<String>(entity.getDealer_id(), 1);
		}catch (org.springframework.dao.DuplicateKeyException e){
			return new Result<String>(entity.getDealer_id(), 2);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new Result<String>(entity.getDealer_id(), 0);
	}
	
	
	@ResponseBody
	@RequestMapping("delete")
	public Result<String> delete(@RequestParam(value = "id", required = true) String id) {
		try {
			dealerAuthDiscountService.deleteEntity(id);
			return new Result<String>(id, 1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new Result<String>(id, 0);
	}
	

	
	
	
	
	
	
}
