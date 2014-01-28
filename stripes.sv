module stripes(input logic CLOCK_50 , 
				
				output logic [9:0]VGA_R,
				output logic [9:0]VGA_G,
				output logic [9:0]VGA_B,
				output logic VGA_CLK , VGA_BLANK ,VGA_HS ,VGA_VS  );
				
				logic video_on, video_on_v, video_on_h;
				logic [9:0]h_count, v_count;

				assign video_on = video_on_v & video_on_h;
				assign VGA_CLK = CLOCK_50;
				assign VGA_BLANK = video_on; //  active low
					
				// heavily based on VHDL, p197 of Rapid Prototyping of Digital Systems
				always @(posedge(CLOCK_50))	
				 begin
					// pixel count and horizontal sync
					if (h_count == 815) h_count = 10'b0; else h_count = h_count + 1;
					if (h_count < 756 & h_count > 660) VGA_HS = 0; else VGA_HS = 1;  // active low
					
					// line count and vertical sync
					if (v_count > 523 & h_count > 699) v_count = 10'b0;
					else if (h_count == 699) v_count = v_count + 1;
					if (v_count <495 & v_count > 492) VGA_VS = 0; else VGA_VS = 1;
					
					// generate pixels
					if (h_count < 640) video_on_h = 1; else video_on_h = 0;
					if (v_count < 480) video_on_v = 1; else video_on_v = 0;
					
					if (video_on) case /*({h_count[4:3]})// ({v_count[6:5]})//
								*/({h_count[6],v_count[6]})
					0:  begin 
							VGA_R = 10'b0;
							VGA_G = 10'b0;
							VGA_B =  {v_count[5:0] & 6'b111111,4'b0};
						 end
					1:	 begin
							VGA_R = 10'b1111111111;
							VGA_G = 10'b0;
							VGA_B = 10'b0;
						 end
					2:	 begin
							VGA_R = 10'b0;
							VGA_G = 10'b1111111111;
							VGA_B = 10'b0;
						 end
					3:	 begin
							VGA_R = 10'b1111111111;
							VGA_G = 10'b1111111111;
							VGA_B = 10'b1111111111;
						 end
					
					endcase
					else begin 
							VGA_R = 10'b0;
							VGA_G = 10'b0;
							VGA_B = 10'b0;
						 end		
				 end
endmodule
			

