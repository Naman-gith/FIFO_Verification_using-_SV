class fifo_monitor;

    virtual fifo_if vif;
    mailbox #(fifo_txn) mon2scb;

    function new(virtual fifo_if vif, mailbox #(fifo_txn) mon2scb);
        this.vif = vif;
        this.mon2scb = mon2scb;
    endfunction

    task run();
        fifo_txn tx;
        forever begin
            @(posedge vif.clk);
            tx = new();
            tx.wr = vif.wr_en;
            tx.rd = vif.rd_en;
            tx.data = vif.dout;
            mon2scb.put(tx);
        end
    endtask

endclass
