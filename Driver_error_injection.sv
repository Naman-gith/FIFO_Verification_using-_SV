class fifo_driver;

    virtual fifo_if vif;
    mailbox #(fifo_txn) gen2drv;

    rand bit inject_overflow;
    rand bit inject_underflow;

    function new(virtual fifo_if vif, mailbox #(fifo_txn) gen2drv);
        this.vif = vif;
        this.gen2drv = gen2drv;
    endfunction

    task run();
        fifo_txn tx;
        forever begin
            gen2drv.get(tx);
            assert(this.randomize());
            drive(tx);
        end
    endtask

    task drive(fifo_txn tx);
        vif.wr_en <= tx.wr;
        vif.rd_en <= tx.rd;
        vif.din   <= tx.data;

        if (inject_overflow)
            vif.wr_en <= 1;

        if (inject_underflow)
            vif.rd_en <= 1;

        @(posedge vif.clk);

        vif.wr_en <= 0;
        vif.rd_en <= 0;
    endtask

endclass
