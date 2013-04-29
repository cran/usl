### R code from vignette source 'usl.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: options
###################################################
options(prompt="R> ", scipen=4, digits=3, width=68, show.signif.stars=FALSE)
options(SweaveHooks=list(fig = function() par(mar = c(4.1, 4.1, 2.1, 2.1))))
set.seed(42, kind = "default", normal.kind = "default")


###################################################
### code chunk number 2: usl.Rnw:183-186
###################################################
library(usl)
data(raytracer)
raytracer


###################################################
### code chunk number 3: rtplot1
###################################################
plot(throughput ~ processors, data=raytracer)


###################################################
### code chunk number 4: usl.Rnw:207-208
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(throughput ~ processors, data=raytracer)


###################################################
### code chunk number 5: usl.Rnw:222-223
###################################################
usl.model <- usl(throughput ~ processors, data=raytracer)


###################################################
### code chunk number 6: usl.Rnw:228-229
###################################################
summary(usl.model)


###################################################
### code chunk number 7: usl.Rnw:261-262
###################################################
efficiency(usl.model)


###################################################
### code chunk number 8: rtbarplot
###################################################
barplot(efficiency(usl.model), ylab="efficiency / processor", xlab="processors")


###################################################
### code chunk number 9: usl.Rnw:275-276
###################################################
getOption("SweaveHooks")[["fig"]]()
barplot(efficiency(usl.model), ylab="efficiency / processor", xlab="processors")


###################################################
### code chunk number 10: usl.Rnw:289-290
###################################################
coef(usl.model)


###################################################
### code chunk number 11: usl.Rnw:296-297
###################################################
confint(usl.model, level = 0.95, type = "norm")


###################################################
### code chunk number 12: rtplot2
###################################################
plot(throughput ~ processors, data=raytracer, pch=16)
plot(usl.model, add=TRUE)


###################################################
### code chunk number 13: usl.Rnw:318-319
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(throughput ~ processors, data=raytracer, pch=16)
plot(usl.model, add=TRUE)


###################################################
### code chunk number 14: usl.Rnw:331-332
###################################################
predict(usl.model, data.frame(processors=c(96, 128)))


###################################################
### code chunk number 15: usl.Rnw:340-341
###################################################
peak.scalability(usl.model)


###################################################
### code chunk number 16: usl.Rnw:358-361
###################################################
library(usl)
data(specsdm91)
specsdm91


###################################################
### code chunk number 17: usl.Rnw:374-375
###################################################
usl.model <- usl(throughput ~ load, specsdm91, method = "nlxb")


###################################################
### code chunk number 18: usl.Rnw:405-406
###################################################
summary(usl.model)


###################################################
### code chunk number 19: usl.Rnw:419-421
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
### code chunk number 21: usl.Rnw:459-460
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(specsdm91, pch=16, ylim=c(0,2500))
plot(usl.model, add=TRUE)
cache.scale <- scalability(usl.model, kappa=0.00005)
curve(cache.scale, lty=2, add=TRUE)


###################################################
### code chunk number 22: usl.Rnw:474-476
###################################################
scalability(usl.model)(peak.scalability(usl.model))
scalability(usl.model, kappa=0.00005)(peak.scalability(usl.model, kappa=0.00005))


