class fifo_scoreboard;

    mailbox #(fifo_txn) mon2scb;
    bit [7:0] ref_q[$];

    function new(mailbox #(fifo_txn) mon2scb);
        this.mon2scb = mon2scb;
    endfunction

    task run();
        fifo_txn tx;
        forever begin
            mon2scb.get(tx);

            if (tx.wr)
                ref_q.push_back(tx.data);

            if (tx.rd && ref_q.size() > 0) begin
                bit [7:0] exp = ref_q.pop_front();
                if (exp !== tx.data)
                    $display("FAIL exp=%0h got=%0h", exp, tx.data);
                else
                    $display("PASS %0h", exp);
            end
        end
    endtask

endclass
