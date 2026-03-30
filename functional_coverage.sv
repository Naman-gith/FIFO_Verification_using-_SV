class fifo_coverage;

    virtual fifo_if vif;

    int level;

    covergroup fifo_cg @(posedge vif.clk);

        option.per_instance = 1;

        wr_cp : coverpoint vif.wr_en;
        rd_cp : coverpoint vif.rd_en;

        level_cp : coverpoint level {
            bins empty = {0};
            bins mid[] = {[1:14]};
            bins full = {15};
        }

        cross wr_cp, rd_cp, level_cp;

    endgroup

    function new(virtual fifo_if vif);
        this.vif = vif;
        fifo_cg = new();
    endfunction

    task sample(int cnt);
        level = cnt;
        fifo_cg.sample();
    endtask

endclass
