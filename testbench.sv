module tb_parallel_adder_4bit;

    reg [3:0] A, B;
    reg Cin;
    wire [3:0] Sum;
    wire Cout;

    integer i, j, k;
    reg [4:0] expected_sum;

    parallel_adder_4bit dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        $dumpfile("tb_parallel_adder_4bit.vcd");
        $dumpvars(0, tb_parallel_adder_4bit);
        $display("Starting 4-bit Parallel Adder Testbench...");
        $display("A   B   Cin | Sum Cout | Expected | Pass/Fail");

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                for (k = 0; k < 2; k = k + 1) begin
                    A = i[3:0];
                    B = j[3:0];
                    Cin = k[0];
                    #1;
                    expected_sum = A + B + Cin;

                    if ({Cout, Sum} == expected_sum) begin
                        $display("%b %b   %b   | %b   %b   | %b       | PASS",
                                 A, B, Cin, Sum, Cout, expected_sum);
                    end else begin
                        $display("%b %b   %b   | %b   %b   | %b       | FAIL <<<",
                                 A, B, Cin, Sum, Cout, expected_sum);
                    end
                end
            end
        end

        $finish;
    end

endmodule