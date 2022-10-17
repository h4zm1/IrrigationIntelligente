from rest_framework.response import Response
from rest_framework.views import APIView
from .serializer import InputSerializer
from .models import Input

class InputView(APIView):
	def get(self, request):
		inputs= Input.objects.all()
		serializer = InputSerializer(inputs, many=True)
		return Response({"inputs": serializer.data})

	def post(self, request):
		input= request.data.get('input')

		# create an input from above data
		serializer = InputSerializer(data=input)
		if serializer.is_valid(raise_exception=True):
			input_saved = serializer.save()
		return Response({"success": "input with temp '{}' created successfully".format(input_saved.temperature)})

#class InputViewSet(viewsets.ModelViewSet):
#    queryset = Input.objects.all()
#    serializer_class = InputModelSerializer