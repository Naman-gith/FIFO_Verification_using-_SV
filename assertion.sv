module fifo_assertions(fifo_if vif);

    property no_overflow;
        @(posedge vif.clk)
        vif.full |-> !vif.wr_en;
    endproperty

    property no_underflow;
        @(posedge vif.clk)
        vif.empty |-> !vif.rd_en;
    endproperty

    property count_bounds;
        @(posedge vif.clk)
        (1) |-> (vif.full || vif.empty || 1);
    endproperty

    assert property(no_overflow);
    assert property(no_underflow);
    assert property(count_bounds);

endmodule
