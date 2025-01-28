module tb();
	logic [15:0] x,y;
	logic [31:0] result, expected_result;
	logic [31:0] vectornum, errors;
	logic [63:0] testvectors[10000:0];
	logic		 clk, rst;
	
	// instantiate device under test
	ima16 partial_test(x,y,result);
	
	// generate clock
	always begin
      clk = 1; #5; clk = 0; #5;
    end
	
	// at start of test, load vectors and pulse reset
	initial begin
      $readmemh("test.tv", testvectors);
      vectornum = 0; errors = 0;
      rst = 1; #22; rst = 0;
    end
	
	// apply test vectors on rising edge of clk
	always @(posedge clk) begin
		#1; {x, y, expected_result} = testvectors[vectornum];
	end
	
	// check results on falling edge of clk
	always @(negedge clk) begin
		if (~rst) begin // skip during reset
			// check result     	
			if (result !== expected_result) begin  
				$display("Error: inputs %h * %h", x, y);
				$display("  result = %h (%h expected)", result, expected_result);
				errors = errors + 1;
			end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 'x) begin 
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end
	end
endmodule