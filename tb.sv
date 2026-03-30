module tb;

    logic clk;
    always #5 clk = ~clk;

    fifo_if vif(clk);
    fifo_env env;

    fifo_sync dut (
        .clk(clk),
        .rst(vif.rst),
        .wr_en(vif.wr_en),
        .rd_en(vif.rd_en),
        .din(vif.din),
        .dout(vif.dout),
        .full(vif.full),
        .empty(vif.empty),
        .count()
    );

    fifo_assertions sva(vif);

    initial begin
        clk = 0;
        vif.rst = 1;
        #20;
        vif.rst = 0;

        env = new(vif);
        env.run();

        #2000;
        $finish;
    end

endmodule
