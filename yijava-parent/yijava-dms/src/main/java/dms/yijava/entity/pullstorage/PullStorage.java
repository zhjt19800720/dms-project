package dms.yijava.entity.pullstorage;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PullStorage {
	public String id;
	public String pull_storage_code;
	public String pull_storage_no;
	public String fk_pull_storage_party_id;
	public String pull_storage_party_name;
	public String fk_pull_storage_user_id;
	public String pull_storage_user_name;
	public String pull_storage_date;
	
	public String put_storage_code;
	public String put_storage_no;
	public String fk_put_storage_party_id;
	public String put_storage_party_name;
	public String fk_put_storage_user_id;
	public String put_storage_user_name;
	public String put_storage_date;
	
	public String type;
	public String total_number;
	public String total_money;
	public String status;
	public String pull_start_date;
	public String pull_end_date;
	public String put_start_date;
	public String put_end_date;
	
	public String create_date;
	public String last_time;
	
	public String record_id;
	public String record_status;
	public String check_id;	
}
