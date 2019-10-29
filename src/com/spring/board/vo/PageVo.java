package com.spring.board.vo;

import java.util.List;

public class PageVo {
	
	private int pageNo = 1;
	private List<String> search;
	
	public List<String> getSearch() {
		return search;
	}

	public void setSearch(List<String> search) {
		this.search = search;
	}
	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	
}
