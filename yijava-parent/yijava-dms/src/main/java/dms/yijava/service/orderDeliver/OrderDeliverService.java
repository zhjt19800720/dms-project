package dms.yijava.service.orderDeliver;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.yijava.orm.core.JsonPage;
import com.yijava.orm.core.PageRequest;
import com.yijava.orm.core.PropertyFilter;

import dms.yijava.dao.orderDeliver.OrderDeliverDao;
import dms.yijava.entity.orderDeliver.OrderDeliver;

@Service
@Transactional
public class OrderDeliverService {

	@Autowired
	private OrderDeliverDao orderDeliverDao;

	public JsonPage<OrderDeliver> paging(PageRequest pageRequest,
			List<PropertyFilter> filters) {
		Map<String, String> parameters = new HashMap<String, String>();
		for (PropertyFilter propertyFilter : filters) {
			String propertyKey = propertyFilter.getPropertyNames()[0];
			parameters.put(propertyKey, propertyFilter.getMatchValue());
		}
		return orderDeliverDao.getScrollData(parameters,
				pageRequest.getOffset(), pageRequest.getPageSize(),
				pageRequest.getOrderBy(), pageRequest.getOrderDir());
	}
	
	
	public OrderDeliver queryDeliverConsigneeStatus(String deliver_code){
		return orderDeliverDao.getObject(".queryDeliverConsigneeStatus", deliver_code);
	}
	
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public void submitConsignee(OrderDeliver entity) {
		orderDeliverDao.updateObject(".submitConsignee",entity);
		
		
		
	}

}
