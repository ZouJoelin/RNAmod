import mappy as mp


def rna2dna(rna_seq):

    return rna_seq.replace('U', 'T')


def dna2rna(dna_seq):

    return dna_seq.replace('T', 'U')


def correct_by_reference(seq_col, reference_file):

    corrected_seq_col = seq_col.copy()

    # load or build index
    reference_idx = mp.Aligner(reference_file, best_n=1) 
    if not reference_idx: raise Exception("ERROR: failed to load/build reference index")

    for i, (ori_seq) in enumerate(seq_col):
        # traverse alignments
        for match in reference_idx.map(rna2dna(ori_seq)):
            # print(f"seq:{i}\tref_pos:<{match.r_st}-{match.r_en}>  query_pos:<{match.q_st}-{match.q_en}>\t\
            #         match_ratio:{match.mlen}/{len(ori_seq)}\t\
            #         corrected_seq:{reference_idx.seq(match.ctg, start=match.r_st, end=match.r_en)}")
            corrected_seq = reference_idx.seq(match.ctg, start=match.r_st, end=match.r_en)
            corrected_seq_col[i] = dna2rna(corrected_seq)
            break

    return corrected_seq_col


def seq2label(seq_col, modify):

    if modify == "m6A":
        label_col = seq_col.str.replace('A', '1', regex=True).str.replace('[UCG]', '0', regex=True)
    else:
        label_col = seq_col.str.replace('[AUCG]', '0', regex=True)
    
    return label_col

