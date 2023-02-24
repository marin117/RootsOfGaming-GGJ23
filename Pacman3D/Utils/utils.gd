static func linspace(start, end, num):
	var res = []
	if num == 0:
		return res
	if num == 1:
		res.append(start)
	var delta = (end - start) / float((num - 1))
	for i in range(num-1):
		res.append(float(start + delta * i))
	res.append(end)
	return res
