; ModuleID = 'baseline_2.cl'
source_filename = "baseline_2.cl"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@ScanLargeArrays_kernel.block = internal unnamed_addr global [512 x i32] undef, align 16
@prefixSum_kernel.block = internal unnamed_addr global [512 x i32] undef, align 16
@blockAddition_kernel.value.0 = internal unnamed_addr global i32 undef, align 4


; Function Attrs: convergent nounwind uwtable
define dso_local spir_kernel void @prefixSum_kernel(i32* noalias nocapture %output, i32* noalias nocapture readonly %input, i32 %length) local_unnamed_addr #0 !kernel_arg_addr_space !11 !kernel_arg_access_qual !12 !kernel_arg_type !13 !kernel_arg_base_type !13 !kernel_arg_type_qual !14 {
entry:
  %call = tail call i64 @get_local_id(i32 0) #2
  %conv = trunc i64 %call to i32
  %mul = shl nsw i32 %conv, 1
  %idxprom = sext i32 %mul to i64
  %arrayidx = getelementptr inbounds i32, i32* %input, i64 %idxprom
  %0 = load i32, i32* %arrayidx, align 4, !tbaa !7
  %arrayidx3 = getelementptr inbounds [512 x i32], [512 x i32]* @prefixSum_kernel.block, i64 0, i64 %idxprom
  store i32 %0, i32* %arrayidx3, align 8, !tbaa !7
  %add = or i32 %mul, 1
  %idxprom5 = sext i32 %add to i64
  %arrayidx6 = getelementptr inbounds i32, i32* %input, i64 %idxprom5
  %1 = load i32, i32* %arrayidx6, align 4, !tbaa !7
  %arrayidx10 = getelementptr inbounds [512 x i32], [512 x i32]* @prefixSum_kernel.block, i64 0, i64 %idxprom5
  store i32 %1, i32* %arrayidx10, align 4, !tbaa !7
  %d.0124 = lshr i32 %length, 1
  %cmp125 = icmp eq i32 %d.0124, 0
  br i1 %cmp125, label %for.cond.cleanup, label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %entry
  %add18 = add nsw i32 %mul, 2
  br label %for.body

for.cond.cleanup:                                 ; preds = %if.end, %entry
  %offset.0.lcssa = phi i32 [ 1, %entry ], [ %mul26, %if.end ]
  %cmp28 = icmp eq i32 %conv, 0
  br i1 %cmp28, label %if.then30, label %if.end34

for.body:                                         ; preds = %for.body.lr.ph, %if.end
  %d.0128 = phi i32 [ %d.0124, %for.body.lr.ph ], [ %d.0, %if.end ]
  %offset.0126 = phi i32 [ 1, %for.body.lr.ph ], [ %mul26, %if.end ]
  tail call void @barrier(i32 1) #2
  %cmp12 = icmp sgt i32 %d.0128, %conv
  br i1 %cmp12, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %mul16 = mul nsw i32 %offset.0126, %add
  %sub = add nsw i32 %mul16, -1
  %mul19 = mul nsw i32 %offset.0126, %add18
  %sub20 = add nsw i32 %mul19, -1
  %idxprom21 = sext i32 %sub to i64
  %arrayidx22 = getelementptr inbounds [512 x i32], [512 x i32]* @prefixSum_kernel.block, i64 0, i64 %idxprom21
  %2 = load i32, i32* %arrayidx22, align 4, !tbaa !7
  %idxprom23 = sext i32 %sub20 to i64
  %arrayidx24 = getelementptr inbounds [512 x i32], [512 x i32]* @prefixSum_kernel.block, i64 0, i64 %idxprom23
  %3 = load i32, i32* %arrayidx24, align 4, !tbaa !7
  %add25 = add nsw i32 %3, %2
  store i32 %add25, i32* %arrayidx24, align 4, !tbaa !7
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  %mul26 = shl nsw i32 %offset.0126, 1
  %d.0 = lshr i32 %d.0128, 1
  %cmp = icmp eq i32 %d.0, 0
  br i1 %cmp, label %for.cond.cleanup, label %for.body

if.then30:                                        ; preds = %for.cond.cleanup
  %sub31 = add i32 %length, -1
  %idxprom32 = zext i32 %sub31 to i64
  %arrayidx33 = getelementptr inbounds [512 x i32], [512 x i32]* @prefixSum_kernel.block, i64 0, i64 %idxprom32
  store i32 0, i32* %arrayidx33, align 4, !tbaa !7
  br label %if.end34

if.end34:                                         ; preds = %if.then30, %for.cond.cleanup
  %cmp37121 = icmp ugt i32 %length, 1
  br i1 %cmp37121, label %for.body40.lr.ph, label %for.cond.cleanup39

for.body40.lr.ph:                                 ; preds = %if.end34
  %add52 = add nsw i32 %mul, 2
  br label %for.body40

for.cond.cleanup39:                               ; preds = %for.inc65, %if.end34
  tail call void @barrier(i32 1) #2
  %4 = load i32, i32* %arrayidx3, align 8, !tbaa !7
  %arrayidx73 = getelementptr inbounds i32, i32* %output, i64 %idxprom
  store i32 %4, i32* %arrayidx73, align 4, !tbaa !7
  %5 = load i32, i32* %arrayidx10, align 4, !tbaa !7
  %arrayidx81 = getelementptr inbounds i32, i32* %output, i64 %idxprom5
  store i32 %5, i32* %arrayidx81, align 4, !tbaa !7
  ret void

for.body40:                                       ; preds = %for.body40.lr.ph, %for.inc65
  %offset.1123 = phi i32 [ %offset.0.lcssa, %for.body40.lr.ph ], [ %shr41, %for.inc65 ]
  %d35.0122 = phi i32 [ 1, %for.body40.lr.ph ], [ %mul66, %for.inc65 ]
  %shr41 = ashr i32 %offset.1123, 1
  tail call void @barrier(i32 1) #2
  %cmp42 = icmp sgt i32 %d35.0122, %conv
  br i1 %cmp42, label %if.then44, label %for.inc65

if.then44:                                        ; preds = %for.body40
  %mul48 = mul nsw i32 %shr41, %add
  %sub49 = add nsw i32 %mul48, -1
  %mul53 = mul nsw i32 %shr41, %add52
  %sub54 = add nsw i32 %mul53, -1
  %idxprom55 = sext i32 %sub49 to i64
  %arrayidx56 = getelementptr inbounds [512 x i32], [512 x i32]* @prefixSum_kernel.block, i64 0, i64 %idxprom55
  %6 = load i32, i32* %arrayidx56, align 4, !tbaa !7
  %idxprom57 = sext i32 %sub54 to i64
  %arrayidx58 = getelementptr inbounds [512 x i32], [512 x i32]* @prefixSum_kernel.block, i64 0, i64 %idxprom57
  %7 = load i32, i32* %arrayidx58, align 4, !tbaa !7
  store i32 %7, i32* %arrayidx56, align 4, !tbaa !7
  %8 = load i32, i32* %arrayidx58, align 4, !tbaa !7
  %add63 = add nsw i32 %8, %6
  store i32 %add63, i32* %arrayidx58, align 4, !tbaa !7
  br label %for.inc65

for.inc65:                                        ; preds = %for.body40, %if.then44
  %mul66 = shl nsw i32 %d35.0122, 1
  %cmp37 = icmp ult i32 %mul66, %length
  br i1 %cmp37, label %for.body40, label %for.cond.cleanup39
}


