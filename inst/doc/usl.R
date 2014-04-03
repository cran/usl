### R code from vignette source 'usl.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: options
###################################################
options(prompt="R> ", scipen=4, digits=3, width=68, show.signif.stars=FALSE)
options(SweaveHooks=list(fig = function() par(mar = c(4.1, 4.1, 2.1, 2.1))))
set.seed(42, kind = "default", normal.kind = "default")


###################################################
### code chunk number 2: usl.Rnw:182-185
###################################################
library(usl)
data(raytracer)
raytracer


###################################################
### code chunk number 3: rtplot1
###################################################
plot(throughput ~ processors, data=raytracer)


###################################################
### code chunk number 4: usl.Rnw:206-207
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(throughput ~ processors, data=raytracer)


###################################################
### code chunk number 5: usl.Rnw:221-222
###################################################
usl.model <- usl(throughput ~ processors, data=raytracer)


###################################################
### code chunk number 6: usl.Rnw:227-228
###################################################
summary(usl.model)


###################################################
### code chunk number 7: usl.Rnw:260-261
###################################################
efficiency(usl.model)


###################################################
### code chunk number 8: rtbarplot
###################################################
barplot(efficiency(usl.model), ylab="efficiency / processor", xlab="processors")


###################################################
### code chunk number 9: usl.Rnw:274-275
###################################################
getOption("SweaveHooks")[["fig"]]()
barplot(efficiency(usl.model), ylab="efficiency / processor", xlab="processors")


###################################################
### code chunk number 10: usl.Rnw:288-289
###################################################
coef(usl.model)


###################################################
### code chunk number 11: usl.Rnw:295-296
###################################################
confint(usl.model, level = 0.95, type = "norm")


###################################################
### code chunk number 12: rtplot2
###################################################
plot(throughput ~ processors, data=raytracer, pch=16)
plot(usl.model, add=TRUE)


###################################################
### code chunk number 13: usl.Rnw:317-318
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(throughput ~ processors, data=raytracer, pch=16)
plot(usl.model, add=TRUE)


###################################################
### code chunk number 14: usl.Rnw:330-331
###################################################
predict(usl.model, data.frame(processors=c(96, 128)))


###################################################
### code chunk number 15: usl.Rnw:339-340
###################################################
peak.scalability(usl.model)


###################################################
### code chunk number 16: usl.Rnw:357-360
###################################################
library(usl)
data(specsdm91)
specsdm91


###################################################
### code chunk number 17: usl.Rnw:373-374
###################################################
usl.model <- usl(throughput ~ load, specsdm91, method = "nlxb")


###################################################
### code chunk number 18: usl.Rnw:404-405
###################################################
summary(usl.model)


###################################################
### code chunk number 19: usl.Rnw:418-420
###################################################
peak.scalability(usl.model)
peak.scalability(usl.model, kappa=0.00005)


###################################################
### code chunk number 20: spplot1
###################################################
plot(specsdm91, pch=16, ylim=c(0,2500))
plot(usl.model, add=TRUE)
cache.scale <- scalability(usl.model, kappa=0.00005)
curve(cache.scale, lty=2, add=TRUE)


###################################################
### code chunk number 21: usl.Rnw:458-459
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(specsdm91, pch=16, ylim=c(0,2500))
plot(usl.model, add=TRUE)
cache.scale <- scalability(usl.model, kappa=0.00005)
curve(cache.scale, lty=2, add=TRUE)


###################################################
### code chunk number 22: usl.Rnw:473-475
###################################################
scalability(usl.model)(peak.scalability(usl.model))
scalability(usl.model, kappa=0.00005)(peak.scalability(usl.model, kappa=0.00005))


