; ModuleID = 'SWI.cl'
source_filename = "SWI.cl"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local spir_kernel void @Histogram_kernel(i32 %size, i32 %bins, float %alpha, i32* nocapture readonly %data, i32* nocapture %histo) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !5 !kernel_arg_base_type !5 !kernel_arg_type_qual !6 {
entry:
  %l_histo = alloca [256 x i32], align 16
  %0 = bitcast [256 x i32]* %l_histo to i8*
  call void @llvm.lifetime.start.p0i8(i64 1024, i8* nonnull %0) #2
  %cmp42 = icmp sgt i32 %bins, 0
  br i1 %cmp42, label %for.body.preheader, label %for.cond1.preheader

for.body.preheader:                               ; preds = %entry
  %1 = zext i32 %bins to i64
  %2 = shl nuw nsw i64 %1, 2
  call void @llvm.memset.p0i8.i64(i8* nonnull align 16 %0, i8 0, i64 %2, i1 false)
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %for.body.preheader, %entry
  %cmp240 = icmp sgt i32 %size, 0
  br i1 %cmp240, label %for.body4.preheader, label %for.cond14.preheader

for.body4.preheader:                              ; preds = %for.cond1.preheader
  %wide.trip.count46 = zext i32 %size to i64
  %xtraiter52 = and i64 %wide.trip.count46, 1
  %3 = icmp eq i32 %size, 1
  br i1 %3, label %for.cond14.preheader.loopexit.unr-lcssa, label %for.body4.preheader.new

for.body4.preheader.new:                          ; preds = %for.body4.preheader
  %unroll_iter54 = sub nsw i64 %wide.trip.count46, %xtraiter52
  br label %for.body4

for.cond14.preheader.loopexit.unr-lcssa:          ; preds = %for.body4, %for.body4.preheader
  %indvars.iv44.unr = phi i64 [ 0, %for.body4.preheader ], [ %indvars.iv.next45.1, %for.body4 ]
  %lcmp.mod53 = icmp eq i64 %xtraiter52, 0
  br i1 %lcmp.mod53, label %for.cond14.preheader, label %for.body4.epil

for.body4.epil:                                   ; preds = %for.cond14.preheader.loopexit.unr-lcssa
  %arrayidx6.epil = getelementptr inbounds i32, i32* %data, i64 %indvars.iv44.unr
  %4 = load i32, i32* %arrayidx6.epil, align 4, !tbaa !7
  %mul.epil = mul i32 %4, %bins
  %shr.epil = lshr i32 %mul.epil, 12
  %idxprom7.epil = zext i32 %shr.epil to i64
  %arrayidx8.epil = getelementptr inbounds [256 x i32], [256 x i32]* %l_histo, i64 0, i64 %idxprom7.epil
  %5 = load i32, i32* %arrayidx8.epil, align 4, !tbaa !7
  %inc9.epil = add i32 %5, 1
  store i32 %inc9.epil, i32* %arrayidx8.epil, align 4, !tbaa !7
  br label %for.cond14.preheader

for.cond14.preheader:                             ; preds = %for.body4.epil, %for.cond14.preheader.loopexit.unr-lcssa, %for.cond1.preheader
  br i1 %cmp42, label %for.body17.preheader, label %for.cond.cleanup16

for.body17.preheader:                             ; preds = %for.cond14.preheader
  %wide.trip.count = zext i32 %bins to i64
  %6 = add nsw i64 %wide.trip.count, -1
  %xtraiter = and i64 %wide.trip.count, 3
  %7 = icmp ult i64 %6, 3
  br i1 %7, label %for.cond.cleanup16.loopexit.unr-lcssa, label %for.body17.preheader.new

for.body17.preheader.new:                         ; preds = %for.body17.preheader
  %unroll_iter = sub nsw i64 %wide.trip.count, %xtraiter
  br label %for.body17

for.body4:                                        ; preds = %for.body4, %for.body4.preheader.new
  %indvars.iv44 = phi i64 [ 0, %for.body4.preheader.new ], [ %indvars.iv.next45.1, %for.body4 ]
  %niter55 = phi i64 [ %unroll_iter54, %for.body4.preheader.new ], [ %niter55.nsub.1, %for.body4 ]
  %arrayidx6 = getelementptr inbounds i32, i32* %data, i64 %indvars.iv44
  %8 = load i32, i32* %arrayidx6, align 4, !tbaa !7
  %mul = mul i32 %8, %bins
  %shr = lshr i32 %mul, 12
  %idxprom7 = zext i32 %shr to i64
  %arrayidx8 = getelementptr inbounds [256 x i32], [256 x i32]* %l_histo, i64 0, i64 %idxprom7
  %9 = load i32, i32* %arrayidx8, align 4, !tbaa !7
  %inc9 = add i32 %9, 1
  store i32 %inc9, i32* %arrayidx8, align 4, !tbaa !7
  %indvars.iv.next45 = or i64 %indvars.iv44, 1
  %arrayidx6.1 = getelementptr inbounds i32, i32* %data, i64 %indvars.iv.next45
  %10 = load i32, i32* %arrayidx6.1, align 4, !tbaa !7
  %mul.1 = mul i32 %10, %bins
  %shr.1 = lshr i32 %mul.1, 12
  %idxprom7.1 = zext i32 %shr.1 to i64
  %arrayidx8.1 = getelementptr inbounds [256 x i32], [256 x i32]* %l_histo, i64 0, i64 %idxprom7.1
  %11 = load i32, i32* %arrayidx8.1, align 4, !tbaa !7
  %inc9.1 = add i32 %11, 1
  store i32 %inc9.1, i32* %arrayidx8.1, align 4, !tbaa !7
  %indvars.iv.next45.1 = add nuw nsw i64 %indvars.iv44, 2
  %niter55.nsub.1 = add i64 %niter55, -2
  %niter55.ncmp.1 = icmp eq i64 %niter55.nsub.1, 0
  br i1 %niter55.ncmp.1, label %for.cond14.preheader.loopexit.unr-lcssa, label %for.body4

for.cond.cleanup16.loopexit.unr-lcssa:            ; preds = %for.body17, %for.body17.preheader
  %indvars.iv.unr = phi i64 [ 0, %for.body17.preheader ], [ %indvars.iv.next.3, %for.body17 ]
  %lcmp.mod = icmp eq i64 %xtraiter, 0
  br i1 %lcmp.mod, label %for.cond.cleanup16, label %for.body17.epil

for.body17.epil:                                  ; preds = %for.cond.cleanup16.loopexit.unr-lcssa, %for.body17.epil
  %indvars.iv.epil = phi i64 [ %indvars.iv.next.epil, %for.body17.epil ], [ %indvars.iv.unr, %for.cond.cleanup16.loopexit.unr-lcssa ]
  %epil.iter = phi i64 [ %epil.iter.sub, %for.body17.epil ], [ %xtraiter, %for.cond.cleanup16.loopexit.unr-lcssa ]
  %arrayidx19.epil = getelementptr inbounds [256 x i32], [256 x i32]* %l_histo, i64 0, i64 %indvars.iv.epil
  %12 = load i32, i32* %arrayidx19.epil, align 4, !tbaa !7
  %arrayidx21.epil = getelementptr inbounds i32, i32* %histo, i64 %indvars.iv.epil
  %13 = load i32, i32* %arrayidx21.epil, align 4, !tbaa !7
  %add.epil = add i32 %13, %12
  store i32 %add.epil, i32* %arrayidx21.epil, align 4, !tbaa !7
  %indvars.iv.next.epil = add nuw nsw i64 %indvars.iv.epil, 1
  %epil.iter.sub = add i64 %epil.iter, -1
  %epil.iter.cmp = icmp eq i64 %epil.iter.sub, 0
  br i1 %epil.iter.cmp, label %for.cond.cleanup16, label %for.body17.epil, !llvm.loop !11

for.cond.cleanup16:                               ; preds = %for.cond.cleanup16.loopexit.unr-lcssa, %for.body17.epil, %for.cond14.preheader
  call void @llvm.lifetime.end.p0i8(i64 1024, i8* nonnull %0) #2
  ret void

for.body17:                                       ; preds = %for.body17, %for.body17.preheader.new
  %indvars.iv = phi i64 [ 0, %for.body17.preheader.new ], [ %indvars.iv.next.3, %for.body17 ]
  %niter = phi i64 [ %unroll_iter, %for.body17.preheader.new ], [ %niter.nsub.3, %for.body17 ]
  %arrayidx19 = getelementptr inbounds [256 x i32], [256 x i32]* %l_histo, i64 0, i64 %indvars.iv
  %14 = load i32, i32* %arrayidx19, align 16, !tbaa !7
  %arrayidx21 = getelementptr inbounds i32, i32* %histo, i64 %indvars.iv
  %15 = load i32, i32* %arrayidx21, align 4, !tbaa !7
  %add = add i32 %15, %14
  store i32 %add, i32* %arrayidx21, align 4, !tbaa !7
  %indvars.iv.next = or i64 %indvars.iv, 1
  %arrayidx19.1 = getelementptr inbounds [256 x i32], [256 x i32]* %l_histo, i64 0, i64 %indvars.iv.next
  %16 = load i32, i32* %arrayidx19.1, align 4, !tbaa !7
  %arrayidx21.1 = getelementptr inbounds i32, i32* %histo, i64 %indvars.iv.next
  %17 = load i32, i32* %arrayidx21.1, align 4, !tbaa !7
  %add.1 = add i32 %17, %16
  store i32 %add.1, i32* %arrayidx21.1, align 4, !tbaa !7
  %indvars.iv.next.1 = or i64 %indvars.iv, 2
  %arrayidx19.2 = getelementptr inbounds [256 x i32], [256 x i32]* %l_histo, i64 0, i64 %indvars.iv.next.1
  %18 = load i32, i32* %arrayidx19.2, align 8, !tbaa !7
  %arrayidx21.2 = getelementptr inbounds i32, i32* %histo, i64 %indvars.iv.next.1
  %19 = load i32, i32* %arrayidx21.2, align 4, !tbaa !7
  %add.2 = add i32 %19, %18
  store i32 %add.2, i32* %arrayidx21.2, align 4, !tbaa !7
  %indvars.iv.next.2 = or i64 %indvars.iv, 3
  %arrayidx19.3 = getelementptr inbounds [256 x i32], [256 x i32]* %l_histo, i64 0, i64 %indvars.iv.next.2
  %20 = load i32, i32* %arrayidx19.3, align 4, !tbaa !7
  %arrayidx21.3 = getelementptr inbounds i32, i32* %histo, i64 %indvars.iv.next.2
  %21 = load i32, i32* %arrayidx21.3, align 4, !tbaa !7
  %add.3 = add i32 %21, %20
  store i32 %add.3, i32* %arrayidx21.3, align 4, !tbaa !7
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv, 4
  %niter.nsub.3 = add i64 %niter, -4
  %niter.ncmp.3 = icmp eq i64 %niter.nsub.3, 0
  br i1 %niter.ncmp.3, label %for.cond.cleanup16.loopexit.unr-lcssa, label %for.body17
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1) #1

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "denorms-are-zero"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "uniform-work-group-size"="true" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0}
!opencl.ocl.version = !{!1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, i32 0}
!2 = !{!"clang version 9.0.0 (https://github.com/llvm/llvm-project.git 75afc0105c089171f9d85d59038617fb222c38cd)"}
!3 = !{i32 0, i32 0, i32 0, i32 1, i32 1}
!4 = !{!"none", !"none", !"none", !"none", !"none"}
!5 = !{!"int", !"int", !"float", !"uint*", !"uint*"}
!6 = !{!"", !"", !"", !"", !""}
!7 = !{!8, !8, i64 0}
!8 = !{!"int", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
!11 = distinct !{!11, !12}
!12 = !{!"llvm.loop.unroll.disable"}
