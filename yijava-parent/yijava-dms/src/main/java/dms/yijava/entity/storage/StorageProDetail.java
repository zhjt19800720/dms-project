package dms.yijava.entity.storage;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class StorageProDetail {

	private String id;
	private String fk_storage_id;
	private String fk_dealer_id;
	//private String order_code;
	//private String pull_storage_code;
	//private String type;
	private String status;
	private String batch_no;
	private String product_sn;
	


}