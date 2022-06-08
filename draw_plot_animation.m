% read input data file
[ctrl1, bado1, bfrag1, ctrl2, bado2, bfrag2] = readvars('data.xlsx');

results_vector = [ctrl1, bado1, bfrag1, ctrl2, bado2, bfrag2];

% set time shots
times_len = size(ctrl1);
times_len = times_len(1); %24 frames
times = 1:times_len;
writer_obj = VideoWriter('MFI_plot.avi');
writer_obj.FrameRate = 5;
open(writer_obj);
fig = figure;
%[xmin xmax ymin ymax]
axis([1 length(results_vector)+1 min(min(results_vector))-0.01 max(max(results_vector))+0.01])
%colors = ['g*','y*','r*','g*','g*'];
xlabel('Frame');
ylabel('MFI');
hold on

for k = 1 :length(results_vector)
 % plot(times(1:k),results_vector(1:k,:)); hold on % ,'Color', colors
  plot(times(1:k),results_vector(1:k,1), 'g'); % ctrl1
  plot(times(1:k),results_vector(1:k,2), 'k'); %legend('b.ado1'); hold on %bado1
  plot(times(1:k),results_vector(1:k,3), 'b'); %bfrag1
  plot(times(1:k),results_vector(1:k,4), 'g'); %legend('ctrl2');% ctrl2
  plot(times(1:k),results_vector(1:k,5), 'k'); %legend('b.ado2')%bado2
  plot(times(1:k),results_vector(1:k,6), 'b'); %bfrag2
  title( sprintf('Time point = %.1f minutes', times(k)*15) );
  ln = legend('ctrl1','b.ado1', 'b.frag1', 'ctrl2', 'b.ado2', 'b.frag2');
  ln.Position = [0.2 0.6 0.1 0.3];
  F = getframe(fig);
  M(k) = getframe;
  writeVideo(writer_obj, F);
  hold all
  pause( 0.1 );
end
close(writer_obj);

movie(M,1);
hold off