h = get_channel(1,6,2,1);
h1 = h(:,1).';
h2 = h(:,2).';
D = 2;
g = good_waveform_multiple_simplified(D,h.');

g1 = g(1,:);
g2 = g(2,:);
   
   weight1 = sum(abs(h1).^2);
   weight2 = sum(abs(h2).^2);
   
   plot(abs(conv(g1,h1)),'-r'); hold on
   plot(abs(conv(conj(h1(end:-1:1)),h1/weight1)),'-b'); hold off
   
   xlabel('channel taps')
   ylabel('Magnitude')
   legend('MMSE','TR')
   figure;plot(abs(conv(g2,h2)),'-r'); hold on
   plot(abs(conv(conj(h2(end:-1:1)),h2/weight2)),'-b'); hold off
   
      xlabel('channel taps')
   ylabel('Magnitude')
   legend('MMSE','TR')
   figure;plot(abs(conv(g1,h2)),'-r'); hold on
   plot(abs(conv(conj(h1(end:-1:1)),h2/weight1)),'-b'); hold off
   axis([0 200 0 1])
   xlabel('channel taps')
   ylabel('Magnitude')
   legend('MMSE','TR')
   
   figure;plot(abs(conv(g2,h1)),'-r'); hold on
   plot(abs(conv(conj(h2(end:-1:1)),h1)/weight2),'-b'); hold off
   axis([0 200 0 1])
   xlabel('channel taps')
   ylabel('Magnitude')
   legend('MMSE','TR')
 
   