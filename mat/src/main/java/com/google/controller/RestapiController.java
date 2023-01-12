package com.google.controller;



import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.domain.GbVO;
import com.google.mapper.RestapiMapper;
import com.google.service.RestapiService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/apitest/*")
@AllArgsConstructor
@Log4j
public class RestapiController {

	private RestapiService service;
	
	@GetMapping(value="/Gb", produces = "application/json; charset=utf8")
	public ResponseEntity<String> getGb() throws Exception {

        int insertCount = 0;
        int arraySize = 10;
        
		for(int a = 1; arraySize == 10; a++) {	//10은 pageRow값
	        String result = uriencode(a);
	        
	        System.out.println(result);
	        
	        try {
	        	JSONParser jsonParser = new JSONParser();
				JSONObject jsonObject = (JSONObject) jsonParser.parse(result);

				JSONArray jsonArray = (JSONArray) jsonObject.get("data");
				
				//long jsonPage = (long) jsonObject.get("page");
				arraySize = jsonArray.size();
				
				for(int i = 0; i<jsonArray.size(); i++) {
					JSONObject object = (JSONObject) jsonArray.get(i);
					GbVO gbVO = new GbVO();
					gbVO.setSno((long) object.get("연번"));
					gbVO.setRepresent((String) object.get("대표자"));
					gbVO.setStore((String) object.get("업소명"));
					gbVO.setMenu((String) object.get("주메뉴"));
					gbVO.setAddr((String) object.get("주소"));
					
					insertCount = service.insert(gbVO);
					
				}
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        
        
        return insertCount >= 1
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
        
	}

	private String uriencode(int page) throws Exception {
		String apiUrl = "http://api.odcloud.kr/api/15063332/v1/uddi:134baef3-4d16-4e67-bca8-8dcf607a004c";
		//int page = 1;
		int perPage = 10;
		String serviceKey = "MVhp%2B2QLgpxUMGSim8B6OuSXb66J5X5pG1TkLLQLXor8LhXJzLYFDvD07RrJxuPGWJJXga3%2BscuR1mvhzI5oFg%3D%3D";
		
		
		StringBuilder urlBuilder = new StringBuilder(apiUrl);
		urlBuilder.append("?" + URLEncoder.encode("page","UTF-8") + "=" + URLEncoder.encode(Integer.toString(page), "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("perPage","UTF-8") + "=" + URLEncoder.encode(Integer.toString(perPage), "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("serviceKey","UTF-8") + "="+serviceKey);
		
	    /*
         * GET방식으로 전송해서 파라미터 받아오기
         */
	    URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
		return sb.toString();
	}
	
}

