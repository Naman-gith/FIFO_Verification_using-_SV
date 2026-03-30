class fifo_env;

    fifo_driver drv;
    fifo_monitor mon;
    fifo_scoreboard scb;
    fifo_coverage cov;

    mailbox #(fifo_txn) gen2drv;
    mailbox #(fifo_txn) mon2scb;

    function new(virtual fifo_if vif);
        gen2drv = new();
        mon2scb = new();

        drv = new(vif, gen2drv);
        mon = new(vif, mon2scb);
        scb = new(mon2scb);
        cov = new(vif);
    endfunction

    task run();
        fork
            drv.run();
            mon.run();
            scb.run();
        join_none
    endtask

endclass
