package sitv.epg.business.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import sitv.epg.entity.business.DZDP_Address;
import sitv.epg.entity.business.DZDP_Category;
import chances.epg.exception.DaoException;

/**
 * 看吧数据访问类
 * 
 * @author zhangxs
 * 
 */
@Repository
public class DZDP_CategoryService extends EpgBaseDao {
	
	public List<DZDP_Category> getAddressByPid(String pid) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pid", pid);
		try {
			return baseDao.getSqlMapClient().queryForList("getCategoryByPid", params);
		} catch (Exception dae) {
			throw new DaoException(
					"An exception produced  when searching district by pid: "
							+ pid, dae);
		}finally{
			params.clear();
			params = null;
		}
	}

}
