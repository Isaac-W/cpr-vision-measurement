import peakutils
import numpy as np
from matplotlib import pyplot as plt

'''
data = [-0.15238721652,
        0.226482259955,
        0.526641892155,
        0.590276999704,
        0.391593530271,
        0.149487519326,
        -0.0464324239059,
        -0.214412432486,
        -0.399365551117,
        -0.78249236592,
        -1.39743628254,
        -2.12135372321,
        -2.4414543013,
        -2.10576560302,
        -1.45197676735,
        -0.718998380028,
        -0.0489282142727,
        0.329713080875,
        0.632288112611,
        0.813656834684,
        0.788783912896,
        0.583532737115,
        0.26490990456,
        -0.0550061028609,
        -0.204124245458,
        -0.413068508087,
        -0.413068508087,
        -2.51865641418,
        -3.19472318458,
        -3.25479975779,
        -3.35534026774,
        -2.03007689523,
        -1.14272760807,
        -0.460896379405,
        0.115842032703,
        0.454346076784,
        0.696686886974,
        0.831096319069,
        0.870736806389,
        0.574412251486,
        0.200983011821,
        -0.053325352345,
        -0.272528390764,
        -0.532293961852,
        -1.09188729712,
        -1.95314294359,
        -2.91710141937,
        -2.47373197362,
        -2.04441831455,
        -1.34801016396,
        -0.470370067137,
        0.0994785276813,
        0.456221035689,
        0.650423019675,
        0.478678636502,
        0.200997779093,
        -0.0464496402702,
        -0.208785044251,
        -0.330719074996,
        -0.550990357407,
        -0.87196620878,
        -1.71307475742,
        -1.91851771846,
        -2.88890405543,
        -2.66298086624,
        -1.92714431099,
        -1.06139833397,
        -0.29624950148,
        0.180283998186,
        0.526295849222,
        0.673532656157,
        0.426462186417,
        0.060120159328,
        -0.14594738248,
        -0.269081387275,
        -0.404828588061,
        -0.742044810136,
        -0.742044810136,
        -1.98679944735,
        -2.81202239783,
        -2.86007533844,
        -2.35135790845,
        -1.34669868327,
        -0.602662592149,
        0.00170301190652,
        0.00170301190652,
        1.26181157041,
        0.751985827159,
        0.454792491419,
        0.14107860018,
        -0.096446361373,
        -0.321997987567,
        -0.512380739993,
        -0.512380739993,
        -1.46137288168,
        -2.30506888031,
        -2.85600776016,
        -3.11585066214,
        -2.84500557881,
        -1.99540337077,
        -1.99540337077,
        -1.99540337077,
        0.419423165143,
        0.511663196427,
        0.473687578856,
        0.309711668411,
        -0.0304144752569,
        -0.227464653615,
        -0.45853074006,
        -1.11898357561,
        -1.11898357561,
        -2.08920896931,
        -2.87885024538,
        -2.58651190777,
        -2.17506212147,
        -1.30980861482,
        -1.30980861482,
        0.053867457816,
        0.468634558648,
        0.724129201681,
        0.640776100176,
        0.371220972916,
        0.00062589024688,
        -0.183872193313,
        -0.361346044001,
        -0.595823005208,
        -1.10714576345,
        -1.6499208654,
        -2.58106532646,
        -2.61920660828,
        -2.18349097801,
        -1.28511828926,
        -1.28511828926,
        -0.0349441314052,
        0.366163090718,
        0.700846185742,
        0.725981238323,
        0.430724819408,
        -0.013151347623,
        -0.219383581303,
        -0.355442491807,
        -0.601167618242,
        -1.29136920468,
        -1.82792576011,
        -3.06477211856,
        -2.78974033952,
        -2.17532750576,
        -2.17532750576,
        -2.17532750576,
        0.0100824452739,
        0.358600267654]
'''

'''
data = [-2.52224738206,
        -2.43286966597,
        -1.84749290261,
        -1.17561330528,
        -0.257505541003,
        0.225763359075,
        0.484975179579,
        0.590294697296,
        0.538122687123,
        0.389105930861,
        0.127409021954,
        -0.0976112044392,
        -0.282028968142,
        -0.606184580378,
        -1.21115775443,
        -2.17626466557,
        -2.64932321828,
        -2.3906022696,
        -1.60525961606,
        -0.900653908075,
        -0.0220441546468,
        0.378001400458,
        0.621486801155,
        0.676242611087,
        0.486036211774,
        0.125416263581,
        -0.201245178062,
        -0.535102228662,
        -1.18602770271,
        -2.1829433139,
        -2.6433974597,
        -2.30850139356,
        -1.74219710589,
        -0.809943952804,
        -0.0304982752981,
        0.413889553232,
        0.662663460059,
        0.808114596491,
        0.804205469722,
        0.612341290937,
        0.23741741988,
        -0.0824271628307,
        -0.35051682177,
        -0.917671536605,
        -1.8090418013,
        -2.42988862532,
        -2.28857768152,
        -1.77367461676,
        -1.12489412763,
        -0.169460620914,
        0.246098649879,
        0.476429573705,
        0.569721963755,
        0.443159016559,
        0.166218891789,
        -0.116946105081,
        -0.263111393389,
        -0.541731029045,
        -1.31177208794,
        -2.12509680506,
        -2.60491281536,
        -2.37254638148,
        -1.8483109875,
        -1.03621026182,
        -0.132681072493,
        0.25723614515,
        0.529346614309,
        0.684379308347,
        0.651173584636,
        0.376075580057,
        0.018171763631,
        -0.18927552813,
        -0.367259824133,
        -0.734740923219,
        -1.37424534445,
        -2.48113020771,
        -2.75365237332,
        -2.47676967334,
        -1.8209902897,
        -1.01338176439,
        -0.127981726016,
        0.235411140932,
        0.45409844315,
        0.487381711888,
        0.389440168451,
        0.17190962931,
        -0.0895438424741,
        -0.297179155264,
        -0.696916022791,
        -1.49920403376,
        -2.26056581485,
        -2.29691651749,
        -1.88536642124,
        -1.18099757478,
        -0.350096671141,
        0.147834639032,
        0.387157151381,
        0.551642564063,
        0.611877913525,
        0.524816070093,
        0.27062489373,
        -0.0200760928386,
        -0.269903933463,
        -0.788851580541,
        -1.58962734054,
        -2.38247410085,
        -2.49917598204,
        -1.98293509099,
        -1.36584393133,
        -0.509170389181,
        0.114705686173,
        0.4184421981,
        0.596063867754,
        0.637323253302,
        0.501799178021,
        0.195284110981,
        -0.109178484199,
        -0.315635048922,
        -0.704592326398,
        -1.6024720669,
        -2.40932347925,
        -2.49212632566,
        -2.07146003545,
        -1.39615349565,
        -0.59679090194,
        0.0931138403406,
        0.379811963829,
        0.583768923804,
        0.712685259493,
        0.649596743732,
        0.374521951738,
        0.0229532428255,
        -0.272619431026,
        -0.701669750037,
        -1.5358550592,
        -2.21298678879,
        -2.36449220513,
        -2.02572333913,
        -1.31249100245,
        -0.573434543623,
        0.0898082658308,
        0.371075758249,
        0.483610377373,
        0.435925163413,
        0.307692746221,
        0.0833775484509,
        -0.0991633544532,
        -0.25621845783,
        -0.714702905138,
        -1.5903042854,
        -2.45064814922]
'''

data = [0.0481802960076,
        0.294296947338,
        0.447603903886,
        0.497841706227,
        0.488011054591,
        0.414856557444,
        0.319857697008,
        0.227989585792,
        0.150080238132,
        0.0963145079273,
        0.0325458419301,
        -0.026162991363,
        -0.108760603109,
        -0.205062781053,
        -0.296605486984,
        -0.411350522941,
        -0.474483437651,
        -0.566470551165,
        -0.66857461351,
        -0.777354999752,
        -0.914522890134,
        -1.0628316454,
        -1.24209135536,
        -1.37850954009,
        -1.55137088677,
        -1.63345414127,
        -1.64196569337,
        -1.71034238332,
        -1.68061067731,
        -1.64735387151,
        -1.71400480781,
        -1.76222090958,
        -1.89883918653,
        -1.95592900229,
        -1.95910369219,
        -1.88932385873,
        -1.84742151112,
        -1.6528244753,
        -1.34418612144,
        -1.00906558786,
        -0.65518761106,
        -0.286683281017,
        0.0630678787807,
        0.317467957894,
        0.459065748629,
        0.535303237891,
        0.515398348064,
        0.429868610637,
        0.323547124786,
        0.232088643539,
        0.180041055865,
        0.118336729484,
        0.0823596871819,
        0.0394898189686,
        -0.00284911683641,
        -0.071185956993,
        -0.14314799998,
        -0.21094491473,
        -0.290457253214,
        -0.375884940913,
        -0.449572492701,
        -0.508757299921,
        -0.59014227449,
        -0.663052089228,
        -0.732749359701,
        -0.8215459586,
        -0.911016090211,
        -0.99386395345,
        -1.11846985198,
        -1.24599020129,
        -1.34885479018,
        -1.47409820792,
        -1.56540002294,
        -1.63434473928,
        -1.69467149811,
        -1.7707020886,
        -1.8181415291,
        -1.88469963783,
        -1.89482575382,
        -1.95691091999,
        -2.01269152385,
        -2.03748909499,
        -1.99907697927,
        -1.94164694152,
        -1.86382585217,
        -1.78233203214,
        -1.67199085142,
        -1.58990771303,
        -1.45667641643,
        -1.32472807726,
        -1.12799901573,
        -0.933604599536,
        -0.797868401248,
        -0.637242291198,
        -0.433128421343,
        -0.250632415388,
        -0.0697693771625,
        0.0874335035309,
        0.210369193452,
        0.309461372126,
        0.361639781721,
        0.376612584821,
        0.335387076321,
        0.283403126364,
        0.191682292752,
        0.104898703386,
        -0.0129178495232,
        -0.11895847851,
        -0.241182905009,
        -0.341899903288,
        -0.447073195383,
        -0.544199725148,
        -0.636881660595,
        -0.731214271112,
        -0.850415962409,
        -0.980946144218,
        -1.10239354196,
        -1.26547279504,
        -1.4084542865,
        -1.49030936299,
        -1.60038261326,
        -1.65637193332,
        -1.71803285252,
        -1.75232242529,
        -1.81739802389,
        -1.87595058581,
        -1.87451759293,
        -1.99825849199,
        -2.07071294165,
        -2.14065521897,
        -2.14100885619,
        -2.16872491579,
        -2.17743269223,
        -2.10132955094,
        -2.05114423522,
        -1.93187594484,
        -1.73449266555,
        -1.51925240505,
        -1.30091072479,
        -1.03890030068,
        -0.791984719846,
        -0.554750443134,
        -0.345584095961,
        -0.163299555784,
        -0.0315076612649,
        0.0815511716345,
        0.179165172242,
        0.246650138283,
        0.277007247098]

# Smooth the data
window_size = 5
smooth_filter = np.array([1 / float(window_size) for x in range(window_size)])
smoothed = np.convolve(np.array(data), smooth_filter, mode='valid')
data = smoothed

x_vals = [x for x in range(0, len(data))]

# Get peaks (for recoil)
peaks = peakutils.indexes(np.array(data), 0.2, 5)
peaks = peaks.astype(int).tolist()

# Get troughs (depth peaks)
neg_data = [-x for x in data]
troughs = peakutils.indexes(np.array(neg_data), 0.2, 5)
troughs = troughs.astype(int).tolist()

#rate_points = peakutils.interpolate(x_vals, neg_data, troughs)
rate_points = troughs

avg_rate = 0
for i in range(1, len(rate_points)):
    # Get time between peaks and convert to rate
    avg_rate += ((len(data) / 5.0) * 60) / float(rate_points[i] - rate_points[i - 1])
if len(rate_points) > 1:
    avg_rate /= (len(rate_points) - 1)

plt.plot(x_vals, data)
plt.plot(peaks, [data[x] for x in peaks], 'rx')
plt.plot(troughs, [data[x] for x in troughs], 'bx')
plt.show()

pass
