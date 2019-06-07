; ModuleID = 'SWI.cl'
source_filename = "SWI.cl"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.flowvector = type { i32, i32, i32, i32 }

; Function Attrs: norecurse nounwind uwtable writeonly
define dso_local i32 @gen_model_param(i32 %x1, i32 %y1, i32 %vx1, i32 %vy1, i32 %x2, i32 %y2, i32 %vx2, i32 %vy2, float* nocapture %model_param) local_unnamed_addr #0 {
entry:
  %mul = shl nsw i32 %vx2, 1
  %sub = sub nsw i32 %vx1, %mul
  %mul1 = mul nsw i32 %sub, %vx1
  %mul2 = mul nsw i32 %vx2, %vx2
  %mul3 = mul nsw i32 %vy1, %vy1
  %mul5 = shl nsw i32 %vy1, 1
  %sub6 = sub nsw i32 %mul5, %vy2
  %mul7 = mul nsw i32 %sub6, %vy2
  %add = add nuw i32 %mul2, %mul3
  %add4 = add i32 %add, %mul1
  %sub8 = sub i32 %add4, %mul7
  %conv = sitofp i32 %sub8 to float
  %cmp = icmp eq i32 %sub8, 0
  br i1 %cmp, label %cleanup, label %if.end

if.end:                                           ; preds = %entry
  %mul12 = mul nsw i32 %x2, %vx1
  %mul16 = mul nsw i32 %vy2, %y1
  %mul18.neg = mul i32 %vy2, %y2
  %mul14.neg208 = add i32 %x1, %x2
  %reass.add198 = mul i32 %mul14.neg208, %vx2
  %reass.add199 = add i32 %reass.add198, %mul18.neg
  %add17 = add i32 %mul16, %mul12
  %sub19 = sub i32 %add17, %reass.add199
  %mul20 = mul nsw i32 %sub19, %vx1
  %mul23 = mul nsw i32 %x2, %vy1
  %mul27 = mul nsw i32 %vx2, %y1
  %mul29 = mul nsw i32 %vx2, %y2
  %reass.mul202 = mul i32 %mul14.neg208, %vy2
  %sub26 = sub i32 %mul23, %mul27
  %sub28 = add i32 %sub26, %mul29
  %add30 = sub i32 %sub28, %reass.mul202
  %mul31 = mul nsw i32 %add30, %vy1
  %mul33 = mul nsw i32 %vy2, %vy2
  %add35 = add nuw nsw i32 %mul33, %mul2
  %mul36 = mul nsw i32 %add35, %x1
  %add32 = add i32 %mul20, %mul36
  %add37 = add i32 %add32, %mul31
  %conv38 = sitofp i32 %add37 to float
  %div = fdiv float %conv38, %conv, !fpmath !3
  store float %div, float* %model_param, align 4, !tbaa !4
  %mul39 = mul nsw i32 %vy1, %x1
  %mul46.neg209 = add i32 %y2, %y1
  %reass.add203 = mul i32 %mul46.neg209, %vx1
  %sub43 = sub i32 %mul39, %mul23
  %add45 = add i32 %sub43, %mul27
  %sub47 = sub i32 %add45, %reass.add203
  %mul48 = mul nsw i32 %sub47, %vx2
  %.neg197 = mul i32 %vx1, %x1
  %mul53.neg = mul i32 %vy1, %y1
  %mul57.neg = mul i32 %y2, %vy1
  %reass.add205 = add i32 %mul53.neg, %.neg197
  %reass.add206 = add i32 %reass.add205, %mul57.neg
  %sub58 = sub i32 %add17, %reass.add206
  %mul59 = mul nsw i32 %sub58, %vy2
  %mul61 = mul nsw i32 %vx1, %vx1
  %add63 = add nuw nsw i32 %mul3, %mul61
  %mul64 = mul nsw i32 %add63, %y2
  %add60 = add i32 %mul59, %mul64
  %add65 = add i32 %add60, %mul48
  %conv66 = sitofp i32 %add65 to float
  %div67 = fdiv float %conv66, %conv, !fpmath !3
  %arrayidx68 = getelementptr inbounds float, float* %model_param, i64 1
  store float %div67, float* %arrayidx68, align 4, !tbaa !4
  %mul69 = shl nsw i32 %x2, 1
  %sub70 = sub nsw i32 %x1, %mul69
  %mul71 = mul nsw i32 %sub70, %x1
  %mul72 = mul nsw i32 %x2, %x2
  %mul74 = shl nsw i32 %y2, 1
  %sub75 = sub nsw i32 %y1, %mul74
  %mul76 = mul nsw i32 %sub75, %y1
  %mul78 = mul nsw i32 %y2, %y2
  %add73 = add nuw i32 %mul78, %mul72
  %add77 = add i32 %add73, %mul71
  %add79 = add i32 %add77, %mul76
  %conv80 = sitofp i32 %add79 to float
  %cmp81 = icmp eq i32 %add79, 0
  br i1 %cmp81, label %cleanup, label %if.end84

if.end84:                                         ; preds = %if.end
  %sub85 = sub nsw i32 %x1, %x2
  %sub86 = sub nsw i32 %vx1, %vx2
  %mul87 = mul nsw i32 %sub86, %sub85
  %sub88 = sub nsw i32 %y1, %y2
  %sub89 = sub nsw i32 %vy1, %vy2
  %mul90 = mul nsw i32 %sub89, %sub88
  %add91 = add nsw i32 %mul90, %mul87
  %conv92 = sitofp i32 %add91 to float
  %div93 = fdiv float %conv92, %conv80, !fpmath !3
  %arrayidx94 = getelementptr inbounds float, float* %model_param, i64 2
  store float %div93, float* %arrayidx94, align 4, !tbaa !4
  %mul97 = mul nsw i32 %sub89, %sub85
  %sub98 = sub nsw i32 %y2, %y1
  %mul100 = mul nsw i32 %sub86, %sub98
  %add101 = add nsw i32 %mul97, %mul100
  %conv102 = sitofp i32 %add101 to float
  %div103 = fdiv float %conv102, %conv80, !fpmath !3
  %arrayidx104 = getelementptr inbounds float, float* %model_param, i64 3
  store float %div103, float* %arrayidx104, align 4, !tbaa !4
  br label %cleanup

cleanup:                                          ; preds = %if.end, %entry, %if.end84
  %retval.0 = phi i32 [ 1, %if.end84 ], [ 0, %entry ], [ 0, %if.end ]
  ret i32 %retval.0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #1

; Function Attrs: convergent nounwind uwtable
define dso_local spir_kernel void @RANSAC_kernel_block(i32 %flowvector_count, i32 %error_threshold, float %convergence_threshold, i32 %n_tasks, %struct.flowvector* noalias nocapture readonly %flowvectors, i32* noalias nocapture readonly %random_numbers, i32* noalias nocapture %model_candidate, i32* noalias nocapture %outliers_candidate, i32* nocapture %g_out_id) local_unnamed_addr #2 !kernel_arg_addr_space !8 !kernel_arg_access_qual !9 !kernel_arg_type !10 !kernel_arg_base_type !10 !kernel_arg_type_qual !11 {
entry:
  %model_param = alloca [4 x float], align 16
  %0 = bitcast [4 x float]* %model_param to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0) #4
  call void @llvm.memset.p0i8.i64(i8* nonnull align 16 %0, i8 0, i64 16, i1 false)
  %cmp186 = icmp sgt i32 %n_tasks, 0
  br i1 %cmp186, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %arrayidx = getelementptr inbounds [4 x float], [4 x float]* %model_param, i64 0, i64 0
  %arrayidx1 = getelementptr inbounds [4 x float], [4 x float]* %model_param, i64 0, i64 1
  %arrayidx2 = getelementptr inbounds [4 x float], [4 x float]* %model_param, i64 0, i64 2
  %arrayidx3 = getelementptr inbounds [4 x float], [4 x float]* %model_param, i64 0, i64 3
  %cmp45182 = icmp sgt i32 %flowvector_count, 0
  %conv90 = sitofp i32 %error_threshold to float
  %conv101 = sitofp i32 %flowvector_count to float
  %mul102 = fmul float %conv101, %convergence_threshold
  %1 = bitcast [4 x float]* %model_param to i8*
  %wide.trip.count = zext i32 %flowvector_count to i64
  %wide.trip.count192 = zext i32 %n_tasks to i64
  br label %for.body

for.cond.cleanup:                                 ; preds = %cleanup, %entry
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0) #4
  ret void

for.body:                                         ; preds = %cleanup, %for.body.lr.ph
  %indvars.iv188 = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next189, %cleanup ]
  %2 = shl nuw nsw i64 %indvars.iv188, 1
  %arrayidx4 = getelementptr inbounds i32, i32* %random_numbers, i64 %2
  call void @llvm.memset.p0i8.i64(i8* nonnull align 16 %1, i8 0, i64 16, i1 false)
  %3 = load i32, i32* %arrayidx4, align 4, !tbaa !12
  %idxprom6 = sext i32 %3 to i64
  %fv.sroa.0.0..sroa_idx = getelementptr inbounds %struct.flowvector, %struct.flowvector* %flowvectors, i64 %idxprom6, i32 0
  %fv.sroa.0.0.copyload = load i32, i32* %fv.sroa.0.0..sroa_idx, align 4
  %fv.sroa.5.0..sroa_idx148 = getelementptr inbounds %struct.flowvector, %struct.flowvector* %flowvectors, i64 %idxprom6, i32 1
  %fv.sroa.5.0.copyload = load i32, i32* %fv.sroa.5.0..sroa_idx148, align 4
  %fv.sroa.7.0..sroa_idx151 = getelementptr inbounds %struct.flowvector, %struct.flowvector* %flowvectors, i64 %idxprom6, i32 2
  %fv.sroa.7.0.copyload = load i32, i32* %fv.sroa.7.0..sroa_idx151, align 4
  %fv.sroa.8.0..sroa_idx153 = getelementptr inbounds %struct.flowvector, %struct.flowvector* %flowvectors, i64 %idxprom6, i32 3
  %fv.sroa.8.0.copyload = load i32, i32* %fv.sroa.8.0..sroa_idx153, align 4
  %4 = or i64 %2, 1
  %arrayidx11 = getelementptr inbounds i32, i32* %random_numbers, i64 %4
  %5 = load i32, i32* %arrayidx11, align 4, !tbaa !12
  %idxprom13 = sext i32 %5 to i64
  %fv.sroa.9.16..sroa_idx = getelementptr inbounds %struct.flowvector, %struct.flowvector* %flowvectors, i64 %idxprom13, i32 0
  %fv.sroa.9.16.copyload = load i32, i32* %fv.sroa.9.16..sroa_idx, align 4
  %fv.sroa.12.16..sroa_idx157 = getelementptr inbounds %struct.flowvector, %struct.flowvector* %flowvectors, i64 %idxprom13, i32 1
  %fv.sroa.12.16.copyload = load i32, i32* %fv.sroa.12.16..sroa_idx157, align 4
  %fv.sroa.14.16..sroa_idx160 = getelementptr inbounds %struct.flowvector, %struct.flowvector* %flowvectors, i64 %idxprom13, i32 2
  %fv.sroa.14.16.copyload = load i32, i32* %fv.sroa.14.16..sroa_idx160, align 4
  %fv.sroa.15.16..sroa_idx162 = getelementptr inbounds %struct.flowvector, %struct.flowvector* %flowvectors, i64 %idxprom13, i32 3
  %fv.sroa.15.16.copyload = load i32, i32* %fv.sroa.15.16..sroa_idx162, align 4
  %sub = sub nsw i32 %fv.sroa.7.0.copyload, %fv.sroa.0.0.copyload
  %sub19 = sub nsw i32 %fv.sroa.8.0.copyload, %fv.sroa.5.0.copyload
  %sub24 = sub nsw i32 %fv.sroa.14.16.copyload, %fv.sroa.9.16.copyload
  %sub29 = sub nsw i32 %fv.sroa.15.16.copyload, %fv.sroa.12.16.copyload
  %call = call i32 @gen_model_param(i32 %fv.sroa.0.0.copyload, i32 %fv.sroa.5.0.copyload, i32 %sub, i32 %sub19, i32 %fv.sroa.9.16.copyload, i32 %fv.sroa.12.16.copyload, i32 %sub24, i32 %sub29, float* nonnull %arrayidx)
  %cmp38 = icmp eq i32 %call, 0
  br i1 %cmp38, label %if.end.thread, label %if.end

if.end.thread:                                    ; preds = %for.body
  store float -2.011000e+03, float* %arrayidx, align 16, !tbaa !4
  br label %cleanup

if.end:                                           ; preds = %for.body
  %.pr = load float, float* %arrayidx, align 16, !tbaa !4
  %cmp41 = fcmp oeq float %.pr, -2.011000e+03
  br i1 %cmp41, label %cleanup, label %for.cond44.preheader

for.cond44.preheader:                             ; preds = %if.end
  br i1 %cmp45182, label %for.body47.lr.ph, label %for.cond.cleanup46

for.body47.lr.ph:                                 ; preds = %for.cond44.preheader
  %6 = load float, float* %arrayidx2, align 8, !tbaa !4
  %7 = load float, float* %arrayidx1, align 4, !tbaa !4
  %8 = load float, float* %arrayidx3, align 4, !tbaa !4
  br label %for.body47

for.cond.cleanup46:                               ; preds = %if.end98, %for.cond44.preheader
  %outlier_local_count.0.lcssa = phi i32 [ 0, %for.cond44.preheader ], [ %outlier_local_count.1, %if.end98 ]
  %conv100 = sitofp i32 %outlier_local_count.0.lcssa to float
  %cmp103 = fcmp ogt float %mul102, %conv100
  br i1 %cmp103, label %if.then105, label %cleanup

for.body47:                                       ; preds = %if.end98, %for.body47.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body47.lr.ph ], [ %indvars.iv.next, %if.end98 ]
  %outlier_local_count.0184 = phi i32 [ 0, %for.body47.lr.ph ], [ %outlier_local_count.1, %if.end98 ]
  %fvreg.sroa.0.0..sroa_idx = getelementptr inbounds %struct.flowvector, %struct.flowvector* %flowvectors, i64 %indvars.iv, i32 0
  %fvreg.sroa.0.0.copyload = load i32, i32* %fvreg.sroa.0.0..sroa_idx, align 4
  %fvreg.sroa.6.0..sroa_idx129 = getelementptr inbounds %struct.flowvector, %struct.flowvector* %flowvectors, i64 %indvars.iv, i32 1
  %fvreg.sroa.6.0.copyload = load i32, i32* %fvreg.sroa.6.0..sroa_idx129, align 4
  %fvreg.sroa.9.0..sroa_idx133 = getelementptr inbounds %struct.flowvector, %struct.flowvector* %flowvectors, i64 %indvars.iv, i32 2
  %fvreg.sroa.9.0.copyload = load i32, i32* %fvreg.sroa.9.0..sroa_idx133, align 4
  %conv = sitofp i32 %fvreg.sroa.0.0.copyload to float
  %sub53 = fsub float %conv, %.pr
  %mul55 = fmul float %sub53, %6
  %conv56 = fptosi float %mul55 to i32
  %conv58 = sitofp i32 %fvreg.sroa.6.0.copyload to float
  %sub60 = fsub float %conv58, %7
  %mul62 = fmul float %sub60, %8
  %conv63 = fptosi float %mul62 to i32
  %sub64 = sub i32 %fvreg.sroa.0.0.copyload, %fvreg.sroa.9.0.copyload
  %add65 = add i32 %sub64, %conv56
  %sub67 = sub i32 %add65, %conv63
  %conv68 = sitofp i32 %sub67 to float
  %call89 = tail call float @llvm.fabs.f32(float %conv68) #5
  %cmp91 = fcmp ult float %call89, %conv90
  br i1 %cmp91, label %lor.lhs.false, label %if.then97

lor.lhs.false:                                    ; preds = %for.body47
  %mul75 = fmul float %6, %sub60
  %conv76 = fptosi float %mul75 to i32
  %mul82 = fmul float %sub53, %8
  %conv83 = fptosi float %mul82 to i32
  %fvreg.sroa.10.0..sroa_idx135 = getelementptr inbounds %struct.flowvector, %struct.flowvector* %flowvectors, i64 %indvars.iv, i32 3
  %fvreg.sroa.10.0.copyload = load i32, i32* %fvreg.sroa.10.0..sroa_idx135, align 4
  %add84 = add i32 %fvreg.sroa.6.0.copyload, %conv83
  %add85 = add i32 %add84, %conv76
  %sub87 = sub i32 %add85, %fvreg.sroa.10.0.copyload
  %conv88 = sitofp i32 %sub87 to float
  %call93 = tail call float @llvm.fabs.f32(float %conv88) #5
  %cmp95 = fcmp ult float %call93, %conv90
  br i1 %cmp95, label %if.end98, label %if.then97

if.then97:                                        ; preds = %lor.lhs.false, %for.body47
  %inc = add nsw i32 %outlier_local_count.0184, 1
  br label %if.end98

if.end98:                                         ; preds = %lor.lhs.false, %if.then97
  %outlier_local_count.1 = phi i32 [ %inc, %if.then97 ], [ %outlier_local_count.0184, %lor.lhs.false ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond, label %for.cond.cleanup46, label %for.body47

if.then105:                                       ; preds = %for.cond.cleanup46
  %9 = load i32, i32* %g_out_id, align 4, !tbaa !12
  %add108 = add nsw i32 %9, 1
  store i32 %add108, i32* %g_out_id, align 4, !tbaa !12
  %idxprom109 = sext i32 %9 to i64
  %arrayidx110 = getelementptr inbounds i32, i32* %outliers_candidate, i64 %idxprom109
  store i32 %outlier_local_count.0.lcssa, i32* %arrayidx110, align 4, !tbaa !12
  %arrayidx112 = getelementptr inbounds i32, i32* %model_candidate, i64 %idxprom109
  %10 = trunc i64 %indvars.iv188 to i32
  store i32 %10, i32* %arrayidx112, align 4, !tbaa !12
  br label %cleanup

cleanup:                                          ; preds = %if.end.thread, %for.cond.cleanup46, %if.then105, %if.end
  %indvars.iv.next189 = add nuw nsw i64 %indvars.iv188, 1
  %exitcond193 = icmp eq i64 %indvars.iv.next189, %wide.trip.count192
  br i1 %exitcond193, label %for.cond.cleanup, label %for.body
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1) #1

; Function Attrs: nounwind readnone speculatable
declare dso_local float @llvm.fabs.f32(float) #3

attributes #0 = { norecurse nounwind uwtable writeonly "correctly-rounded-divide-sqrt-fp-math"="false" "denorms-are-zero"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { convergent nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "denorms-are-zero"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "uniform-work-group-size"="true" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone speculatable }
attributes #4 = { nounwind }
attributes #5 = { convergent }

!llvm.module.flags = !{!0}
!opencl.ocl.version = !{!1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, i32 0}
!2 = !{!"clang version 9.0.0 (https://github.com/llvm/llvm-project.git 75afc0105c089171f9d85d59038617fb222c38cd)"}
!3 = !{float 2.500000e+00}
!4 = !{!5, !5, i64 0}
!5 = !{!"float", !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C/C++ TBAA"}
!8 = !{i32 0, i32 0, i32 0, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1}
!9 = !{!"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none"}
!10 = !{!"int", !"int", !"float", !"int", !"flowvector*", !"int*", !"int*", !"int*", !"int*"}
!11 = !{!"", !"", !"", !"", !"restrict", !"restrict", !"restrict", !"restrict", !""}
!12 = !{!13, !13, i64 0}
!13 = !{!"int", !6, i64 0}
