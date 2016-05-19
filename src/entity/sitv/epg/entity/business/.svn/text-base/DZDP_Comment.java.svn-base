package sitv.epg.entity.business;

import java.util.Date;
/**
 * 
 * @author wz
 *
 */
@SuppressWarnings("serial")
public class DZDP_Comment implements java.io.Serializable {
	private String deal_id;//商品ID
	private String title;//名称
	private String discription;//描述
	private String city;//所属城市
	private String list_price; //单价
	private String current_price;//团购价
	private String categories1;
	private String categories2;
	private String categories3;
	private String categories4;
	private String address;
	private String top_address;
	private Long purchase_count;
	private String publish_date;//上架日期
	private String purchase_deadline;
	private String details;//详情
	private String special_tips;//须知
	private String restriction_is;//是否支持随时退款
	private String twimage_url;//二维码
	private String image_url;//大图
	private String s_images_url;//小图
	private String deal_url;//电脑url
	private int status;//入库状态
	private String deal_h5_url;//手机url
	private int recommend;//是否推荐位
	private String update_date;//更新日期
	private String business_id;//商户id
	private String xmlstauts;//xml状态
	private String twimage_urlFullPath;
	private String twimage_urlIndexUrl;
	private String discount_rate;
	
	
	public String getDeal_id() {
		return deal_id;
	}
	public void setDeal_id(String deal_id) {
		this.deal_id = deal_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getDiscription() {
		return discription;
	}
	public void setDiscription(String discription) {
		this.discription = discription;
	}
	
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	
	public String getList_price() {
		String li_price = list_price.substring(0,list_price.indexOf("."));
		int floatProice = Integer.parseInt(list_price.substring(list_price.indexOf(".")+1,list_price.length()));
		if(floatProice>0){
			li_price = li_price+"."+floatProice;
		}
		list_price = li_price;
		return list_price;
	}
	public void setList_price(String list_price) {
		this.list_price = list_price;
	}
	
	public String getCurrent_price() {
		String cur_price = current_price.substring(0,current_price.indexOf("."));
		int floatProice = Integer.parseInt(current_price.substring(current_price.indexOf(".")+1,current_price.length()));
		if(floatProice>0){
			cur_price = cur_price+"."+floatProice;
		}
		current_price = cur_price;
		return current_price;
	}
	public void setCurrent_price(String current_price) {
		this.current_price = current_price;
	}
	
	public String getCategories1() {
		return categories1;
	}
	public void setCategories1(String categories1) {
		this.categories1 = categories1;
	}
	
	public String getCategories2() {
		return categories2;
	}
	public void setCategories2(String categories2) {
		this.categories2 = categories2;
	}
	
	public String getCategories3() {
		return categories3;
	}
	public void setCategories3(String categories3) {
		this.categories3 = categories3;
	}
	
	public String getCategories4() {
		return categories4;
	}
	public void setCategories4(String categories4) {
		this.categories4 = categories4;
	}
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getTop_address() {
		return top_address;
	}
	public void setTop_address(String top_address) {
		this.top_address = top_address;
	}
	
	public Long getPurchase_count() {
		return purchase_count;
	}
	public void setPurchase_count(Long purchase_count) {
		this.purchase_count = purchase_count;
	}
	
	public String getPublish_date() {
		return publish_date;
	}
	public void setPublish_date(String publish_date) {
		this.publish_date = publish_date;
	}
	public void setPurchase_deadline(String purchase_deadline) {
		this.purchase_deadline = purchase_deadline;
	}
	public String getPurchase_deadline() {
		return purchase_deadline;
	}
	public void setDetails(String details) {
		this.details = details;
	}
	public String getDetails() {
		return details;
	}
	public void setSpecial_tips(String special_tips) {
		this.special_tips = special_tips;
	}
	public String getSpecial_tips() {
		return special_tips;
	}
	public void setRestriction_is(String restriction_is) {
		this.restriction_is = restriction_is;
	}
	public String getRestriction_is() {
		return restriction_is;
	}
	public void setTwimage_url(String twimage_url) {
		this.twimage_url = twimage_url;
	}
	public String getTwimage_url() {
		return twimage_url;
	}
	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}
	public String getImage_url() {
		return image_url;
	}
	public void setS_images_url(String s_images_url) {
		this.s_images_url = s_images_url;
	}
	public String getS_images_url() {
		return s_images_url;
	}
	public void setDeal_url(String deal_url) {
		this.deal_url = deal_url;
	}
	public String getDeal_url() {
		return deal_url;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getStatus() {
		return status;
	}
	public void setDeal_h5_url(String deal_h5_url) {
		this.deal_h5_url = deal_h5_url;
	}
	public String getDeal_h5_url() {
		return deal_h5_url;
	}
	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}
	public int getRecommend() {
		return recommend;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setBusiness_id(String business_id) {
		this.business_id = business_id;
	}
	public String getBusiness_id() {
		return business_id;
	}
	public void setXmlstauts(String xmlstauts) {
		this.xmlstauts = xmlstauts;
	}
	public String getXmlstauts() {
		return xmlstauts;
	}
	public void setTwimage_urlFullPath(String twimage_urlFullPath) {
		this.twimage_urlFullPath = twimage_urlFullPath;
	}
	public String getTwimage_urlFullPath() {
		return twimage_urlFullPath;
	}
	public void setTwimage_urlIndexUrl(String twimage_urlIndexUrl) {
		this.twimage_urlIndexUrl = twimage_urlIndexUrl;
	}
	public String getTwimage_urlIndexUrl() {
		return twimage_urlIndexUrl;
	}
	public void setDiscount_rate(String discount_rate) {
		this.discount_rate = discount_rate;
	}
	public String getDiscount_rate() {
		return discount_rate;
	}
	
}
