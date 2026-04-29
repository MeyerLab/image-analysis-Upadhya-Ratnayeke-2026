function print_pdf(name)
% PRINT_PDF(NAME) prints current figure to pdf, named as NAME. should use
% absolute path otherwise will save in current  folder
%
set(gcf,'Units','Inches');
set(gcf,'renderer','Painters')
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
print(name,'-dpdf');

end

