class HeloController < ApplicationController
	layout 'helo'


	def index
		@header = 'layout sample'
		@footer = 'copyright SYODA-Tuyano 2016.'
		@title = 'New Layout'
		@msg = 'this is sample page!'
	end


end