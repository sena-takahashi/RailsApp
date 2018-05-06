class AjaxController < ApplicationController
	layout 'ajax'
	require 'net/https' # この一行を追加する
	require "json"
	def index
	end


	def data
		if request.post? then
			#logger.info 'postテスト開始'
			#logger.info params['input1']
			#logger.info URI.parse URI.encode 'http://www.google.com/complete/search?hl=en&output=toolbar&q=' + params['input1']
			url2 = URI.escape('http://www.google.com/complete/search?hl=ja&output=toolbar&ie=utf_8&oe=utf_8&q=' + params['input1']+' ')
			url = URI(url2)
			https = Net::HTTP.new(url.host,443)
			https.use_ssl = true
			https.ca_file = 'GTE_CyberTrust_Global_Root.pem'
			https.verify_mode=OpenSSL::SSL::VERIFY_NONE
			https.verify_depth = 5
			response = https.get(url)
			result = Hash.from_xml(response.body).to_json.html_safe
			result=JSON.parse(result)
			@data = Hash.from_xml(response.body).to_json.html_safe
			#logger.info result
			#logger.info result["toplevel"]["CompleteSuggestion"]
			num=0
			result["toplevel"]["CompleteSuggestion"].each do |k|
				keyword = k["suggestion"]["data"]
				#logger.info keyword
				url2 = URI.escape('http://www.google.com/complete/search?hl=ja&output=toolbar&ie=utf_8&oe=utf_8&q=' + keyword +' ')
				url = URI(url2)
				https = Net::HTTP.new(url.host,443)
				https.use_ssl = true
				https.ca_file = 'GTE_CyberTrust_Global_Root.pem'
				https.verify_mode=OpenSSL::SSL::VERIFY_NONE
				https.verify_depth = 5
				response = https.get(url)
				#logger.info Hash.from_xml(response.body).to_json.html_safe
				instance_variable_set('@data_' + (num + 1).to_s, Hash.from_xml(response.body).to_json.html_safe)
				num=num+1
				#logger.info @data_1
			end
			#logger.info @data
		else
			first="知恵の輪"
			url2 = URI.escape('http://www.google.com/complete/search?hl=ja&output=toolbar&ie=utf_8&oe=utf_8&q=' + first +' ')
			url = URI(url2)
			https = Net::HTTP.new(url.host,443)
			https.use_ssl = true
			https.ca_file = 'GTE_CyberTrust_Global_Root.pem'
			https.verify_mode=OpenSSL::SSL::VERIFY_NONE
			https.verify_depth = 5
			response = https.get(url)
			result = Hash.from_xml(response.body).to_json.html_safe
			result=JSON.parse(result)
			@data = Hash.from_xml(response.body).to_json.html_safe
			#logger.info result
			num=0
			result["toplevel"]["CompleteSuggestion"].each do |k|
				keyword = k["suggestion"]["data"]
				#logger.info keyword
				url2 = URI.escape('http://www.google.com/complete/search?hl=ja&output=toolbar&ie=utf_8&oe=utf_8&q=' + keyword +' ')
				url = URI(url2)
				https = Net::HTTP.new(url.host,443)
				https.use_ssl = true
				https.ca_file = 'GTE_CyberTrust_Global_Root.pem'
				https.verify_mode=OpenSSL::SSL::VERIFY_NONE
				https.verify_depth = 5
				response = https.get(url)
				#logger.info Hash.from_xml(response.body).to_json.html_safe
				instance_variable_set('@data_' + (num + 1).to_s, Hash.from_xml(response.body).to_json.html_safe)
				num=num+1
				#logger.info @data_1
			end
		end
	end
	


end