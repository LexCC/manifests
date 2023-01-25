#!/bin/bash

operation=$1
kubectl $operation -f ./kubeflow-storage.yaml
if [ $1 = "$operation" ]; then
	kubectl patch storageclass local-storage -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
fi
kustomize build common/cert-manager/cert-manager/base | kubectl $operation -f -
kustomize build common/cert-manager/kubeflow-issuer/base | kubectl $operation -f -
kustomize build common/istio-1-16/istio-crds/base | kubectl $operation -f -
kustomize build common/istio-1-16/istio-namespace/base | kubectl $operation -f -
kustomize build common/istio-1-16/istio-install/base | kubectl $operation -f -
kustomize build common/dex/overlays/istio | kubectl $operation -f -
kustomize build common/oidc-authservice/base | kubectl $operation -f -
kustomize build common/knative/knative-serving/overlays/gateways | kubectl $operation -f -
kustomize build common/istio-1-16/cluster-local-gateway/base | kubectl $operation -f -
kustomize build common/knative/knative-eventing/base | kubectl $operation -f -
kustomize build common/kubeflow-namespace/base | kubectl $operation -f -
kustomize build common/kubeflow-roles/base | kubectl $operation -f -
kustomize build common/istio-1-16/kubeflow-istio-resources/base | kubectl $operation -f -
kustomize build apps/pipeline/upstream/env/cert-manager/platform-agnostic-multi-user | kubectl $operation -f -
kustomize build contrib/kserve/kserve | kubectl $operation -f -
kustomize build contrib/kserve/models-web-app/overlays/kubeflow | kubectl $operation -f -
kustomize build apps/katib/upstream/installs/katib-with-kubeflow | kubectl $operation -f -
kustomize build apps/centraldashboard/upstream/overlays/kserve | kubectl $operation -f -
kustomize build apps/admission-webhook/upstream/overlays/cert-manager | kubectl $operation -f -
kustomize build apps/jupyter/notebook-controller/upstream/overlays/kubeflow | kubectl $operation -f -
kustomize build apps/jupyter/jupyter-web-app/upstream/overlays/istio | kubectl $operation -f -
kustomize build apps/profiles/upstream/overlays/kubeflow | kubectl $operation -f -
kustomize build apps/volumes-web-app/upstream/overlays/istio | kubectl $operation -f -
kustomize build apps/tensorboard/tensorboards-web-app/upstream/overlays/istio | kubectl $operation -f -
kustomize build apps/tensorboard/tensorboard-controller/upstream/overlays/kubeflow | kubectl $operation -f -
kustomize build apps/training-operator/upstream/overlays/kubeflow | kubectl $operation -f -
kustomize build common/user-namespace/base | kubectl $operation -f -
kubectl $operation -f ./access_kfp_from_jupyter_notebook.yaml
kubectl $operation -f ./notebook-pv.yaml
