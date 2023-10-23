% Function to create a nice rotating animated GIF of 3D volumetric data V

function animation (V)

h = volshow (V, 'BackgroundColor', [0 0 0], 'Renderer', 'MaximumIntensityProjection', 'CameraPosition', [2 2 0], 'CameraUpVector', [1 0 0], 'ColorMap', jet);

camproj ('perspective');

N = 500;

filename = 'animation.gif';
vec = linspace(0, 4 * pi(), N)';
myPosition = 2 * [zeros(size(vec)) cos(vec) sin(vec)];

for idx = 1:N
% Update current view.
	h.CameraPosition = myPosition(idx, :);
% Use getframe to capture image.
	I = getframe(gcf);
	
	[indI, cm] = rgb2ind (I.cdata,256);
% Write frame to the GIF File.
	if idx == 1
		imwrite(indI, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.05);
	else
		imwrite(indI, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.05);
	end
end
